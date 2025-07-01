variable "vpc_id" {
  description = "VPC ID"
  type        = string
}

variable "subnet_id" {
  description = "Public subnet ID for the bastion"
  type        = string
}

variable "my_ip" {
  description = "Your home IP address (for SSH)"
  type        = string
}

variable "key_name" {
  description = "SSH key pair name"
  type        = string
} 