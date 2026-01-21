variable "pub_subnet_id" {
  description = "Public subnet ID"
  type        = string
}

variable "pri_subnet_id" {
  description = "Private subnet ID"
  type        = string
}

variable "security_group_id" {
  description = "Security group ID"
  type        = string
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
}

variable "instance_count" {
  description = "Number of instances to create"
  type        = number
}

variable "project_name" {
  description = "Project name"
  type        = string
}

variable "owner" {
  description = "Owner name"
  type        = string
}