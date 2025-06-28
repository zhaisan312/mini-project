module "vpc" {
  source = "./networking/vpc"

  vpc_cidr = "10.0.0.0/16"
  vpc_name = "my-vpc"
  subnetname1 = "public-subnet-1"
  subnetname2 = "public-subnet-2"
  vpc_subnet_cidr1 = "10.0.1.0/24"
  vpc_subnet_cidr2 = "10.0.2.0/24"
  az1 = "us-east-1a"
  az2 = "us-east-1b"

}