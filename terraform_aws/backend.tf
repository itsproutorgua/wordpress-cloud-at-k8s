terraform {
  backend "s3" {
    bucket         = "mondyk8sbucket1911"  
    key            = "terraform.tfstate"   
    region         = "us-east-1"           
    encrypt        = true                  
    dynamodb_table = "terraform-lock" 
  }
}
