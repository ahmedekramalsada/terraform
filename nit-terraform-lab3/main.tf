module "subnet" {
  source        = "./modules/VPC"
  vpc_1_cider   = var.vpc_1_cider
  pri_sub_cider = var.pri_sub_cider
  pub_sub_cider = var.pub_sub_cider
  ingress_ports = var.ingress_rules
  environment   = var.environment
  vpc_id        = var.vpc_id
  project_name  = var.project_name
  owner         = var.owner
}

module "ec2" {
  source            = "./modules/ec2"
  pub_subnet_id     = module.subnet.pub_subnet_id
  pri_subnet_id     = module.subnet.pri_subnet_id
  security_group_id = module.subnet.security_group_id
  instance_type     = var.instance_type
  instance_count    = var.instance_count
  project_name      = var.project_name
  owner             = var.owner
}