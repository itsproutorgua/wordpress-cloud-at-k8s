terraform {
  backend "http" {
    address        = "https://github.com/itsproutorgua/wordpress-cloud-at-k8s/terraform/state/blog-production"
    lock_address   = "https://github.com/itsproutorgua/wordpress-cloud-at-k8s/terraform/state/blog-production/lock"
    lock_method    = "POST"
    unlock_address = "https://github.com/itsproutorgua/wordpress-cloud-at-k8s/terraform/state/blog-production/lock"
    unlock_method  = "DELETE"
    retry_wait_min = 5
  }
}