variable "vpc_1_cider" {
  type = string
}
variable "pri_sub_cider" {
  type = string
}

variable "pub_sub_cider" {
  type = string
}

variable "ingress_ports" {
  description = "List of ingress port configurations"
  type = list(object({
    from_port   = number
    to_port     = number
    protocol    = string
    cidr_blocks = list(string)
    description = string
  }))
}

variable "environment" {
  description = "Environment name (prod or non-prod)"
  type        = string
}

variable "vpc_id" {
  type        = string
  description = "The ID of the existing VPC"
}

variable "project_name" {
  type        = string
  description = "Project name for tags"
}

variable "owner" {
  type        = string
  description = "Owner name for tags"
}