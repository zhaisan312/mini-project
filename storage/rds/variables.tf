variable "db_identifier" {
  description = "The database identifier"
  type        = string
}

variable "engine_version" {
  description = "The database engine version"
  type        = string
}

variable "instance_class" {
  description = "The instance class"
  type        = string
}

variable "allocated_storage" {
  description = "The allocated storage in GB"
  type        = number
}

variable "storage_type" {
  description = "The storage type"
  type        = string
}

variable "db_username" {
  description = "The database username"
  type        = string
}

variable "db_password" {
  description = "The database password"
  type        = string
}

variable "db_name" {
  description = "The database name"
  type        = string
}

variable "vpc_id" {
  description = "The VPC ID where the RDS instance will be created"
  type        = string
  
}
variable "subnet_ids" {
  description = "List of subnet IDs where the RDS instance will be created"
  type        = list(string)
} 