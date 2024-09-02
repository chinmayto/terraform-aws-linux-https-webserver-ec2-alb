################################################################################
# Create VPC and components
################################################################################

module "vpc" {
  source               = "./modules/vpc"
  name                 = "My-VPC"
  aws_region           = var.aws_region
  vpc_cidr_block       = var.vpc_cidr_block_a #"10.1.0.0/16"
  enable_dns_hostnames = var.enable_dns_hostnames
  aws_azs              = var.aws_azs
  common_tags          = local.common_tags
  naming_prefix        = local.naming_prefix
}


################################################################################
# Create Web Server Instances
################################################################################

module "web" {
  source          = "./modules/web"
  ec2_name        = "WebServer"
  instance_type   = var.instance_type
  instance_key    = var.instance_key
  common_tags     = local.common_tags
  naming_prefix   = local.naming_prefix
  vpc_id          = module.vpc.vpc_id
  private_subnets = module.vpc.private_subnets
  depends_on      = [module.vpc]
}


################################################################################
# Create load balancer with target group
################################################################################

module "alb" {
  source         = "./modules/alb"
  aws_region     = var.aws_region
  aws_azs        = var.aws_azs
  common_tags    = local.common_tags
  naming_prefix  = local.naming_prefix
  vpc_id         = module.vpc.vpc_id
  public_subnets = module.vpc.public_subnets
  instance_ids   = module.web.instance_ids
}
