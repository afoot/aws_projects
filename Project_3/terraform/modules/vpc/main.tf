# Purpose: This file is used to create a VPC with 3 public and 3 private subnets in 3 different availability zones.
module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "5.18.0"

  name = var.vpc_name
  cidr = var.vpc_cidr

  azs             = var.azs
  private_subnets = var.private_subnets
  public_subnets  = var.public_subnets
  public_subnet_tags = "${var.vpc_name}-public"
  private_subnet_tags = "${var.vpc_name}-private"
  
  enable_nat_gateway   = true
  single_nat_gateway   = true
  enable_dns_hostnames = true
  enable_dns_support   = true
  enable_dhcp_options  = true

  tags = {
    Name   = "dev"
     }
}
