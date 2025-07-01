output "vpc_my_id" {
  value = module.vpc.vpc_id
}

output "public_subnet_my_ids" {
  value = module.vpc.public_subnet_ids
}

output "bastion_host_security_group_id" {
  value = module.bastion_host.bastion_sg
  
}

output "my_bastion_ip" {
  description = "Bastion host IP from module"
  value       = module.bastion_host.bastion_public_ip
}
