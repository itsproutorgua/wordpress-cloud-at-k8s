terraform {
  backend "gcs" {
    bucket = "mondybucketgcp"
    prefix = "terraform/state"
    credentials = "credentials_file.json"
  }
}