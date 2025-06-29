resource "aws_db_instance" "rds_instance" {
  identifier              = "mini-project-rds"
  engine                  = "mysql"
  engine_version          = "8.0"
  instance_class          = "db.t3.micro"
  allocated_storage       = 20
  storage_type            = "gp2"
  username                = "admin"
  password                = "your_password_here" # Change this to a secure password
  db_name                 = "mini_project_db"
  skip_final_snapshot     = true
  publicly_accessible     = false
  vpc_security_group_ids  = [aws_security_group.rds_sg.id]
  
}