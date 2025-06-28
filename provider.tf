provider "aws" {
  region = "us-east-1"
}

# this is remote state configuration
terraform {
  backend "s3" {
    bucket = "teraform-mini-project-bucket"
    key    = "mini-project/terraform.tfstate"
    region = "us-east-1"
  }
}