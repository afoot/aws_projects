# This file is used to create the core infrastructure for the project. This includes the VPC, ECS Cluster, and Service Discovery.
data "aws_availability_zones" "available" {}

locals {
  name = basename(path.cwd)

  vpc_cidr = "10.0.0.0/16"
  azs      = slice(data.aws_availability_zones.available.names, 0, 3)

  tags = {
    Name = local.name
  }
}

# ECS Cluster

module "ecs_cluster" {
  source  = "terraform-aws-modules/ecs/aws//modules/cluster"
  version = "~> 5.12"

  cluster_name = local.name

  cluster_service_connect_defaults = {
    namespace = aws_service_discovery_private_dns_namespace.this.arn
  }

  fargate_capacity_providers = {
    FARGATE      = {}
    FARGATE_SPOT = {}
  }

  tags = local.tags 
}

# Service Discovery

resource "aws_service_discovery_private_dns_namespace" "this" {
  name        = "default.${local.name}.local"
  description = "Service discovery namespace for the ECS cluster"
  vpc         = module.vpc.vpc_id

  tags = local.tags
}

# VPC
module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "~> 5.0"

  name = local.name
  cidr = local.vpc_cidr

  azs             = local.azs
  public_subnets  = [for k, v in local.azs : cidrsubnet(local.vpc_cidr, 8, k)]
  private_subnets = [for k, v in local.azs : cidrsubnet(local.vpc_cidr, 8, k + 10)]
  private_subnet_tags = {
    "Name" = "Private"
  }

  public_subnet_tags = {
    "Name" = "Public"
  }

  enable_nat_gateway = true
  single_nat_gateway = true

  # Manage so we can name
  manage_default_network_acl    = true
  default_network_acl_tags      = { Name = "${local.name}-default" }
  manage_default_route_table    = true
  default_route_table_tags      = { Name = "${local.name}-default" }
  manage_default_security_group = true
  default_security_group_tags   = { Name = "${local.name}-default" }

  tags = local.tags
}
