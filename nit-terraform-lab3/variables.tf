variable "vpc_1_cider" {
  description = "VPC CIDR block"
  type        = string
  default     = "10.0.0.0/24"
}

variable "pub_sub_cider" {
  description = "Public subnet CIDR block"
  type        = string
  default     = "10.0.0.0/25"
}

variable "pri_sub_cider" {
  description = "Private subnet CIDR block"
  type        = string
  default     = "10.0.0.128/25"
}

variable "environment" {
  description = "Environment name (prod or non-prod)"
  type        = string
  default     = "non-prod"
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t2.micro"
}


variable "instance_count" {
  description = "Number of instances to create"
  type        = number
  default     = 1
}

variable "ingress_rules" {
  description = "List of ingress port configurations"
  type = list(object({
    from_port   = number
    to_port     = number
    protocol    = string
    cidr_blocks = list(string)
    description = string
  }))
  default = [
    {
      from_port   = 80
      to_port     = 80
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
      description = "HTTP"
    },
    {
      from_port   = 22
      to_port     = 22
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
      description = "SSH"
    }
  ]
}

variable "vpc_id" {
  description = "The ID of the existing VPC to use"
  type        = string
  default     = "vpc-00535ad5288838822"
}

variable "project_name" {
  description = "Project name for tagging"
  type        = string
  default     = "terraform-lab3"
}

variable "owner" {
  description = "Owner name for tagging"
  type        = string
  default     = "ahmed ekram"
}


