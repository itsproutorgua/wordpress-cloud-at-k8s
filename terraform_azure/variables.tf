variable "resource_group_name" {
type = string
description = "RG name in Azure" 
default = "aks_tf_test" # Replace a name for your resource group name.
}
variable "location" {
type = string
description = "Resources location in Azure"
default = "EastUS2" # Replace a name for your location.
}
variable "cluster_name" {
type = string
description = "AKS name in Azure"
default = "AKSMondy2022" # Replace a name for your cluster.
}
variable "kubernetes_version" {
type = string
description = "Kubernetes version"
default = "1.26.0"
}
variable "system_node_count" {
type = number
description = "Number of AKS worker nodes"
default = 1
}
variable "domain" {
type = string
description = "You Domain"
default = "it-sproutdevteam.fun" # Replace a name for your domain.
}

