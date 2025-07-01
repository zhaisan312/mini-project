output "bastion_sg" {
  value = aws_security_group.bastion_sg.id
}

output "bastion_public_ip" {
  description = "Public IP of the bastion host"
  value       = aws_instance.bastion.public_ip
}
