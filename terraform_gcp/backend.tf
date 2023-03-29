terraform {
  backend "gcs" {
    bucket = "gcp-bucket-sprout-1"
    prefix = "terraform/state"
    credentials = "credentials_file.json"
  }
}