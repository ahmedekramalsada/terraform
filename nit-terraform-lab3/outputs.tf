output "vpc_id" {
  description = "VPC ID from module"
  value       = module.subnet.vpc_id
}

output "public_subnet_id" {
  value = module.subnet.pub_subnet_id
}

output "private_subnet_id" {
  value = module.subnet.pri_subnet_id
}