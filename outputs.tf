output "vpc_my_id" {
  value = module.vpc.vpc_id
}

output "public_subnet_my_ids" {
  value = module.vpc.public_subnet_ids
}