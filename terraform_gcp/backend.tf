terraform {
  backend "gcs" {
    bucket = "mondybucketgcp" # Replace with you bucket name.
    prefix = "terraform/state"
    credentials = "credentials_file.json"
  }
}
