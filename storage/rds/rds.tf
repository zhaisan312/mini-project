# This Terraform configuration sets up an RDS instance with a subnet group, security group, and parameter group.
resource "aws_db_subnet_group" "rds" {
  subnet_ids = var.subnet_ids

  tags = {
    Name = "mini-project-rds-subnet-group"
  }
}

# This security group allows inbound MySQL traffic on port 3306 from anywhere (0.0.0.0/0)
resource "aws_security_group" "rds_sg" {
  name        = "mini-project-rds-sg"
  vpc_id     = var.vpc_id
  description = "Allow MySQL access from backend"

  ingress {
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    security_groups = var.allowed_security_groups # Allow traffic from specified security groups
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "mini-project-rds-sg"
  }
}

# This resource creates an RDS instance with the specified parameters.
resource "aws_db_instance" "rds_instance" {
  identifier              = var.db_identifier
  engine                  = "mysql"
  engine_version          = var.engine_version
  instance_class          = var.instance_class
  allocated_storage       = var.allocated_storage
  storage_type            = var.storage_type
  username                = var.db_username
  password                = var.db_password
  db_name                 = var.db_name
  db_subnet_group_name    = aws_db_subnet_group.rds.name
  vpc_security_group_ids  = [aws_security_group.rds_sg.id]
  skip_final_snapshot     = true
  publicly_accessible     = true

  tags = {
    Name = var.db_identifier
  }
}

# This resource creates a secret in AWS Secrets Manager to store the RDS credentials.
resource "aws_secretsmanager_secret" "rds_credentials" {
  name = "mini-project-rds-credentials"
}
# This resource creates a secret version in AWS Secrets Manager with the RDS credentials.
resource "aws_secretsmanager_secret_version" "creds" {
  secret_id     = aws_secretsmanager_secret.rds_credentials.id
  secret_string = jsonencode({
    DB_USERNAME = var.db_username
    DB_PASSWORD = var.db_password
    DB_ENDPOINT = aws_db_instance.rds_instance.endpoint
    DB_NAME     = var.db_name
  })
  
}

# This resource creates a parameter group for the RDS instance to customize settings.
resource "aws_db_parameter_group" "rds_parameter_group" {
  name        = "mini-project-rds-parameter-group"
  family      = "mysql8.0"
  description = "Parameter group for mini-project RDS instance"

  # Example parameters to customize the RDS instance
  parameter {
    name  = "max_allowed_packet"
    value = "16777216" # 16 MB
  }

  tags = {
    Name = "mini-project-rds-parameter-group"
  }
}

