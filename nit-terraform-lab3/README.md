# terraform-lab3

This project manages a customized AWS infrastructure using Terraform. It is specifically tailored for **Ahmed Ekram**.

## Project Overview

The project creates a secure VPC environment (leveraging an existing VPC) with public and private subnets, security groups, and EC2 instances running Nginx.

### Features
- **Custom Backend**: State is stored in an S3 bucket in `us-east-1`.
- **Existing VPC Integration**: Connects to `vpc-00535ad5288838822`.
- **Dynamic Tagging**: Every resource is tagged with `Project: terraform-lab3` and `Owner: ahmed ekram`.
- **Multi-Environment**: Supports `prod` and `non-prod` configurations via JSON variable files.
- **Automated Deployment**: Public instances automatically install Nginx and display a custom landing page.

## Project Structure

```text
.
├── main.tf              # Root module calling VPC and EC2 modules
├── variables.tf         # Global variables with defaults
├── providers.tf         # AWS provider and region settings
├── backend.tf           # S3 backend configuration
├── locals_prod.json     # Production environment parameters
├── locals_non_prod.json # Development environment parameters
└── modules/
    ├── VPC/             # Handles subnets, IGW, and Route Tables
    └── ec2/             # Handles Instances, Key Pairs, and Nginx setup
```

## How to Use

### 1. Prerequisites
- AWS CLI configured with appropriate permissions.
- Terraform installed (v1.0.0+).
- SSH Key: The project automatically looks for or generates a key at `~/.ssh/terraform-key`.

### 2. Initialization
```bash
terraform init
```

### 3. Planning
To see what will be created for the development environment:
```bash
terraform plan -var-file="locals_non_prod.json"
```

### 4. Application
```bash
terraform apply -var-file="locals_non_prod.json" -auto-approve
```

## Outputs
After a successful apply, Terraform will provide:
- `vpc_id`: The ID of your existing VPC.
- `public_subnet_id`: The ID of the newly created public subnet.
- `private_subnet_id`: The ID of the newly created private subnet.
- **Web Server URL**: The public IP address of the EC2 instance will be logged in `terraform-lab3-instances.log`.

---
**Owner**: ahmed ekram
**Project**: terraform-lab3
