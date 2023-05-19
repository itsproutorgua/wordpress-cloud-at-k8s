terraform {
  backend "s3" {
    bucket         = "mondyk8sbucket2023"  
    key            = "terraform.tfstate"   
    region         = "us-east-1"           
    encrypt        = true                  
    dynamodb_table = "terraform-lock" 
  }
}
