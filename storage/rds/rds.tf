resource "aws_subnet_group" "rds" {
  name       = "mini-project-rds-subnet-group"
  vpc_id     = aws_vpc.main.id
  subnet_ids = aws_subnet.rds.*.id

  tags = {
    Name = "mini-project-rds-subnet-group"
  }
}

resource "aws_security_group" "rds_sg" {
  name        = "mini-project-rds-sg"
  vpc_id     = aws_vpc.main.id
  description = "Allow MySQL access from backend"

  ingress {
    from_port   = 3306
    to_port     = 3306
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
    Name = "mini-project-rds-sg"
  }
}

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
  db_subnet_group_name = aws_subnet_group.rds.name
  vpc_security_group_ids = [aws_security_group.rds_sg.id]
  skip_final_snapshot = true
  publicly_accessible = true

  tags = {
    Name = var.db_identifier
  }
}

resource "aws_secretsmanager_secret" "rds_credentials" {
  name = "mini-project-rds-credentials"
}
resource "aws_secretsmanager_secret_version" "creds" {
  secret_id     = aws_secretsmanager_secret.rds_credentials.id
  secret_string = jsonencode({
    DB_USERNAME = var.db_username
    DB_PASSWORD = var.db_password
    DB_ENDPOINT = aws_db_instance.rds_instance.endpoint
    DB_NAME     = var.db_name
  })
  
}
resource "aws_db_parameter_group" "rds_parameter_group" {
  name        = "mini-project-rds-parameter-group"
  family      = "mysql8.0"
  description = "Parameter group for mini-project RDS instance"

  parameter {
    name  = "max_allowed_packet"
    value = "16777216" # 16 MB
  }

  tags = {
    Name = "mini-project-rds-parameter-group"
  }
}

