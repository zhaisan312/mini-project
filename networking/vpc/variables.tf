variable "vpc_cidr" {
  description = "The CIDR block for the VPC"
  type = string
}

variable "vpc_name" {
  description = "The name of the VPC"
  type = string
}

variable "subnetname1" {
  description = "The name of the first public subnet"
  type = string
}

variable "subnetname2" {
  description = "The name of the second public subnet"
  type = string
}

variable "vpc_subnet_cidr1" {
  description = "The CIDR block for the first public subnet"
  type = string
}

variable "vpc_subnet_cidr2" {
  description = "The CIDR block for the second public subnet"
  type = string
}

variable "az1" {
  description = "The availability zone for the first public subnet"
  type = string
}

variable "az2" {
  description = "The availability zone for the second public subnet"
  type = string
}
variable "vpc_private_subnet_cidr1" {
  description = "The CIDR block for the first private subnet"
  type = string
}

variable "vpc_private_subnet_cidr2" {
  description = "The CIDR block for the second private subnet"
  type = string
}
variable "private_subnetname1" {
  description = "The name of the first private subnet"
  type = string
}
variable "private_subnetname2" {
  description = "The name of the second private subnet"
  type = string
}