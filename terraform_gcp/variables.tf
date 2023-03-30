variable "def_name" {
  default = "itsprout"
}

variable "project_id" {}

variable "region_prj" {
  default = "us-central1"
}

variable "zone_prj" {
  default = "us-central1-a"
}

variable "sa_name" {
  default = "sa-tf"
}

variable "sa_account" {
  default = "sprout-gcp@enhanced-victor-379417.iam.gserviceaccount.com"
}

variable "local_ip_range" {
  default = "10.100.0.0/28"
}

variable "gke_ip_range" {
  default = "10.200.0.0/19"
}

variable "roles_list" {
  type    = list(string)
  default = ["roles/viewer", "roles/container.admin", "roles/logging.logWriter", "roles/iam.serviceAccountAdmin", "roles/storage.admin", "roles/storage.objectAdmin"]
}