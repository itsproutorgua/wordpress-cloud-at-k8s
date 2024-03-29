variable "def_name" {
  default = "mondyspout" # Replace a name for your resources.
}

variable "project_id" {}

variable "region_prj" {
  default = "us-central1" # Replace with your region.
}

variable "zone_prj" {
  default = "us-central1-a" # Replace with your zone.
}

variable "sa_name" {
  default = "sa-tfstate" # Replace with your name for tfstate.
}

variable "sa_account" {
  default = "git-490@tidy-vent-384809.iam.gserviceaccount.com" # Replace with your service account.
}

variable "domain" {
  default = "it-sproutdevteam.fun" # Replace with your domain.
}
variable "local_ip_range" {
  default = "10.100.0.0/28"
}

variable "gke_ip_range" {
  default = "10.200.0.0/19"
}
