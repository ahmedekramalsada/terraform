output "public_instance_id" {
  description = "Public EC2 instance ID"
  value       = length(aws_instance.pub_ec2) > 0 ? aws_instance.pub_ec2[0].id : null
}

output "public_instance_ip" {
  description = "Public EC2 instance public IP"
  value       = length(aws_instance.pub_ec2) > 0 ? aws_instance.pub_ec2[0].public_ip : null
}

output "private_instance_id" {
  description = "Private EC2 instance ID"
  value       = length(aws_instance.pri_ec2) > 0 ? aws_instance.pri_ec2[0].id : null
}

output "private_instance_ip" {
  description = "Private EC2 instance private IP"
  value       = length(aws_instance.pri_ec2) > 0 ? aws_instance.pri_ec2[0].private_ip : null
}