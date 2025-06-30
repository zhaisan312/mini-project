module "vpc" {
  source = "./networking/vpc"

  vpc_cidr                 = "10.0.0.0/16"
  vpc_name                 = "my-vpc"
  vpc_subnet_cidr1         = "10.0.1.0/24"
  vpc_subnet_cidr2         = "10.0.2.0/24"
  az1                      = "us-east-1a"
  az2                      = "us-east-1b"
  vpc_private_subnet_cidr1 = "10.0.3.0/24"
  vpc_private_subnet_cidr2 = "10.0.4.0/24"

}

module "rds" {
  source = "./storage/rds"

  db_identifier        = "mini-project-rds"
  engine_version       = "8.0"
  instance_class       = "db.t3.micro"
  allocated_storage    = 20
  storage_type         = "gp2"
  db_username          = "admin"
  db_password          = "password1234"
  db_name              = "miniprojectdb"
}
