output "vpc_id" {
  description = "The ID of the VPC"
  value       = data.aws_vpc.vpc_1.id
}

output "pub_subnet_id" {
  description = "Public subnet ID"
  value       = aws_subnet.pub_sub.id
}

output "pri_subnet_id" {
  description = "Private subnet ID"
  value       = aws_subnet.pri_sub.id
}

output "security_group_id" {
  description = "Security group ID"
  value       = aws_security_group.dynamic_sg.id
}

output "internet_gateway_id" {
  description = "Internet Gateway ID"
  value       = aws_internet_gateway.gw.id
}

output "route_table_id" {
  description = "Public route table ID"
  value       = aws_route_table.public_rt.id
}
