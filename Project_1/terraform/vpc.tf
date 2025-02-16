# Purpose: This file is used to create a VPC with 3 public and 3 private subnets in 3 different availability zones.
module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "5.18.0"

  name = var.vpc_name
  cidr = var.vpc_cidr

  azs             = [var.az1, var.az2, var.az3]
  private_subnets = [var.private_sub1, var.private_sub2, var.private_sub3]
  public_subnets  = [var.public_sub1, var.public_sub2, var.public_sub3]

  enable_nat_gateway   = true
  single_nat_gateway   = true
  enable_dns_hostnames = true
  enable_dns_support   = true
  enable_dhcp_options  = true
  dhcp_options_domain_name = "saturn.local"
  dhcp_options_domain_name_servers = ["AmazonProvidedDNS"]

  tags = {
    Terraform   = "true"
    Environment = "Dev"
  }
}
