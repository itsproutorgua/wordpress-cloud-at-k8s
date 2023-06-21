terraform {
  backend "s3" {
    bucket         = "mondyk8sbucket1911"  # Replace with your bucket name.
    key            = "terraform.tfstate"   
    region         = "us-east-1"           
    encrypt        = true                  
    dynamodb_table = "terraform-lock" 
  }
}
