# VPC Configuration for Review App
resource "aws_vpc" "main" {
  cidr_block = var.vpc_cidr
  enable_dns_support = true      
  enable_dns_hostnames = true
  tags = {
    Name = "${var.vpc_name}-review-app"
  }
}
 
# Create public subnets
resource "aws_subnet" "public_subnet_1" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.vpc_subnet_cidr1
  availability_zone = var.az1
  tags = {
    Name = "${var.vpc_name}-review-app -public-1"
  }
  
}

resource "aws_subnet" "public_subnet_2" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.vpc_subnet_cidr2
  availability_zone = var.az2

  tags = {
    Name = "${var.vpc_name}-review-app-public-2"
  }
  
}

# Create private subnets
resource "aws_subnet" "private_subnet_1" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.vpc_private_subnet_cidr1
  availability_zone = var.az1

  tags = {  
    Name = "${var.vpc_name}-review-app-private-1"
  }
}

resource "aws_subnet" "private_subnet_2" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.vpc_private_subnet_cidr2
  availability_zone = var.az2

  tags = {
    Name = "${var.vpc_name}-review-app-private-2"
  }
}

# Create route tables and associations for public subnets
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "${var.vpc_name}-public-route-table"
  }
}
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id
    tags = {
        Name = "${var.vpc_name}-internet-gateway"
    }
}

resource "aws_route_table_association" "public_subnet_1" {
  subnet_id      = aws_subnet.public_subnet_1.id
  route_table_id = aws_route_table.public.id
}
resource "aws_route_table_association" "public_subnet_2" {
  subnet_id      = aws_subnet.public_subnet_2.id
  route_table_id = aws_route_table.public.id
}


# resource "aws_nat_gateway" "main" {
#   allocation_id = aws_eip.nat.id
#   subnet_id    = public_subnets.subnet_1.id
# }

# resource "aws_eip" "nat" {
#     vpc = true
    
#     tags = {
#         Name = "${var.vpc_name}-nat-eip"
#     }
# }
resource "aws_route_table" "private" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "${var.vpc_name}-private-route-table"
  }
}

resource "aws_route_table_association" "private_subnet_1" {
  subnet_id      = aws_subnet.private_subnet_1.id
  route_table_id = aws_route_table.private.id
}
resource "aws_route_table_association" "private_subnet_2" {
  subnet_id      = aws_subnet.private_subnet_2.id
  route_table_id = aws_route_table.private.id
}
resource "aws_security_group" "public_sg" {
  vpc_id = aws_vpc.main.id
  name = "${var.vpc_name}-public-sg"


  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
 
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
    tags = {
        Name = "${var.vpc_name}-public-sg"
    }
}

