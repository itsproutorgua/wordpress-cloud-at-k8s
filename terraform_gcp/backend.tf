terraform {
  backend "gcs" {
    bucket = "mondybucketgcp" # Replace with your bucket name.
    prefix = "terraform/state"
    credentials = "credentials_file.json"
  }
}
