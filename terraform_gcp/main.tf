resource "google_service_account" "service_account" {
  account_id   = "${var.def_name}-${var.sa_name}"
  display_name = "${var.def_name}-${var.sa_name}"
  disabled     = false
  project      = var.project_id
}

resource "google_project_iam_binding" "bind_roles" {
  project = var.project_id
  for_each = toset("${var.roles_list}")
  role     = each.key

  members = [
    "serviceAccount:${google_service_account.service_account.email}"
  ]

  depends_on = [
    google_service_account.service_account
  ]
}

resource "google_compute_subnetwork" "vpc_subnetwork" {
  name                     = "${var.def_name}-subnetwork-${var.zone_prj}"
  ip_cidr_range            = var.local_ip_range
  region                   = var.region_prj
  network                  = google_compute_network.vpc_network.id
  private_ip_google_access = true
}

resource "google_compute_network" "vpc_network" {
  name                    = "${var.def_name}-network"
  auto_create_subnetworks = false
}

resource "google_container_cluster" "k8s_cluster" {
  name               = "${var.def_name}-k8s-cluster"
  location           = var.region_prj
  initial_node_count = 1

  network            = google_compute_network.vpc_network.name
  subnetwork         = google_compute_subnetwork.vpc_subnetwork.name
  enable_legacy_abac = false
  cluster_ipv4_cidr  = var.gke_ip_range

  node_config {
    preemptible     = true
    machine_type    = "g1-small"
    service_account = var.sa_account
    oauth_scopes = [
      "https://www.googleapis.com/auth/cloud-platform"
    ]
    disk_type    = "pd-standard"
    disk_size_gb = 10
  }

  addons_config {
    horizontal_pod_autoscaling {
      disabled = false
    }
  }

  cluster_autoscaling {
    auto_provisioning_defaults {
      disk_size = 10
      disk_type = "pd-standard"
      oauth_scopes = [
        "https://www.googleapis.com/auth/cloud-platform"
      ]
      service_account = var.sa_account
    }
  }

  depends_on = [
    google_compute_network.vpc_network,
    google_compute_subnetwork.vpc_subnetwork
  ]
}

output "cluster_endpoint" {
  value = google_container_cluster.k8s_cluster.endpoint
}

output "cluster_credentials" {
  value     = google_container_cluster.k8s_cluster.master_auth
  sensitive = true
}
