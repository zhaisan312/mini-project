terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">=1.12.2"
    }
  }

# this is remote state configuratio
  backend "s3" {
    bucket = "terraform-bucket-mini-project"
    key    = "mini-project/terraform.tfstate"
    region = "us-east-1"
  }
}

provider "aws" {
  region = "us-east-1"
}
