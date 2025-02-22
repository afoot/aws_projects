# Purpose: This file is used to create the backend service for the ECS cluster.

locals {
  name = basename(path.cwd)

  container_image = var.container_image
  container_port  = var.container_port # Container port is specific to this app example

  tags = {
    Name = local.name
  }
}

# ECS Service

module "ecs_service" {
  source  = "terraform-aws-modules/ecs/aws//modules/service"
  version = "~> 5.6"

  name               = local.name
  desired_count      = 3
  cluster_arn        = data.aws_ecs_cluster.core_infra.arn
  enable_autoscaling = false

  # Task Definition
  enable_execute_command = true

  container_definitions = {
    ecsdemo = {
      image                    = local.container_image
      readonly_root_filesystem = false

      port_mappings = [
        {
          protocol      = "tcp",
          containerPort = local.container_port
        }
      ]
    }
  }

  service_registries = {
    registry_arn = aws_service_discovery_service.this.arn
  }

  subnet_ids = data.aws_subnets.public.ids
  security_group_rules = {
    ingress_all_service = {
      type        = "ingress"
      from_port   = local.container_port
      to_port     = local.container_port
      protocol    = "tcp"
      description = "Service port"
      cidr_blocks = ["0.0.0.0/0"]
    }
    egress_all = {
      type        = "egress"
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }

  tags = local.tags
}

resource "aws_service_discovery_service" "this" {
  name = local.name

  dns_config {
    namespace_id = data.aws_service_discovery_dns_namespace.this.id

    dns_records {
      ttl  = 10
      type = "A"
    }

    routing_policy = "MULTIVALUE"
  }

  health_check_custom_config {
    failure_threshold = 1
  }
}


# Supporting Resources

data "aws_subnets" "public" {
  filter {
    name   = "tag:Name"
    values = ["Public"]
  }
}

data "aws_ecs_cluster" "core_infra" {
  cluster_name = "core-infra"
}

data "aws_service_discovery_dns_namespace" "this" {
  name = "default.${data.aws_ecs_cluster.core_infra.cluster_name}.local"
  type = "DNS_PRIVATE"
}