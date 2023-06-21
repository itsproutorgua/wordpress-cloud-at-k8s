#!/bin/bash
# Getting the EKS cluster name
cluster_name=$(aws eks list-clusters --output text --query 'clusters[0]')

# To get a list of host groups for a cluster
nodegroup_names=$(aws eks list-nodegroups --cluster-name $cluster_name --output text --query 'nodegroups[]')

# Getting a List of Host Groups for a Cluster
for nodegroup_name in $nodegroup_names; do
    echo "Delete Node Group: $nodegroup_name"
    aws eks delete-nodegroup --cluster-name $cluster_name --nodegroup-name $nodegroup_name
    
    # Pending Removal of a Host Groupв
    echo "Waiting to delete a node group: $nodegroup_name"
    aws eks wait nodegroup-deleted --cluster-name $cluster_name --nodegroup-name $nodegroup_name
    echo "Node group removed: $nodegroup_name"

    # Removing Nodes in Group
    echo "Remove Nodes in Group: $nodegroup_name"
    aws ec2 describe-instances --filters "Name=tag:kubernetes.io/cluster/$cluster_name,Values=owned" "Name=tag:k8s.io/cluster-autoscaler/enabled,Values=true" "Name=tag:k8s.io/cluster-autoscaler/node-template/label/k8s.io/cluster-autoscaler/enabled,Values=true" "Name=tag:kubernetes.io/cluster/$cluster_name/node-group/$nodegroup_name,Values=$nodegroup_name" --query 'Reservations[].Instances[].InstanceId' --output text | tr '\t' '\n' | xargs -I {} aws ec2 terminate-instances --instance-ids {}
    echo "Nodes in group deleted: $nodegroup_name"
done

echo "All node groups and associated nodes removed for the cluster: $cluster_name"

echo "Wait 1 minute"
sleep 60 

# Removing Load Balancer
for elb_name in $(aws elb describe-load-balancers --query 'LoadBalancerDescriptions[].LoadBalancerName' --output text); do
  echo "Remove Load Balancer: $elb_name"
  aws elb delete-load-balancer --load-balancer-name "$elb_name"
  echo "Load Balancer removed: $elb_name"
done

echo "Wait 1 minute"
sleep 60 

# Get a list of all NAT Gateway
nat_ids=$(aws ec2 describe-nat-gateways --query 'NatGateways[].NatGatewayId' --output text)
# Delete each NAT Gateway
for nat_id in $nat_ids; do
    echo "Remove NAT Gateway: $nat_id"
    aws ec2 delete-nat-gateway --nat-gateway-id "$nat_id"
    echo "NAT Gateway removed: $nat_id"
done

echo "Wait 1 minute"
sleep 60 


# Get a list of network interface IDs associated with all security groups
interface_ids=$(aws ec2 describe-network-interfaces --query 'NetworkInterfaces[].NetworkInterfaceId' --output text)
# Disable network interfaces from EC2 instances
for interface_id in $interface_ids; do
    echo "Disable network interface from EC2 instances: $interface_id"
    aws ec2 detach-network-interface --attachment-id "$(aws ec2 describe-network-interfaces --network-interface-ids "$interface_id" --query 'NetworkInterfaces[].Attachment.AttachmentId' --output text)"
    echo "Network interface disabled: $interface_id"
done

echo "Wait 1 minute"
sleep 60 

# Delete each network interface
for interface_id in $interface_ids; do
    echo "Remove network interface: $interface_id"
    aws ec2 delete-network-interface --network-interface-id "$interface_id"
    echo "Network interface removed: $interface_id"
done
group_ids=$(aws ec2 describe-security-groups --query 'SecurityGroups[?GroupName!=`default`].[GroupId]' --output text)

# Split the list of security group identifiers into individual rows
IFS=$'\n' read -rd '' -a group_ids_array <<<"$group_ids"

# Search each security group ID and delete it
for group_id in "${group_ids_array[@]}"; do
    if [[ -n "$group_id" ]]; then
        echo "Remove Security Group: $group_id"
        aws ec2 delete-security-group --group-id "$group_id"
        echo "Security group removed: $group_id"
    fi
done

echo "All security groups except 'default' have been deleted"