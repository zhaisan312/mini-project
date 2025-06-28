resource "aws_vpc" "main" {
  cidr_block = var.vpc_cidr

  tags = {
    Name = "${var.vpc_name}-review-app"
  }
}

resource "public_subnets" "subnet_1" {
  vpc_id = aws_vpc.main.id
  cidr_block = var.vpc_subnet_cidr1
  subnetname = var.subnetname1
  availability_zone = var.az1

  tags = {
    Name = "${var.vpc_name}-review-app -public-1"
  }
  
}

resource "public_subnets" "subnet_2" {
  vpc_id = aws_vpc.main.id
  cidr_block = var.vpc_subnet_cidr2
  subnetname = var.subnetname2
  availability_zone = var.az2

  tags = {
    Name = "${var.vpc_name}-review-app-public-2"
  }
  
}
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.main.id
  }

  tags = {
    Name = "${var.vpc_name}-public-route-table"
  }
}