
module "vpc" {
  source   = "./modules/vpc"
  vpc_cidr = var.vpc_cidr
}

module "ecs_cluster" {
  source           = "./modules/ecs_cluster"
  ecs_cluster_name = var.ecs_cluster_name
}

module "ecs_task_definition" {
  source             = "./modules/ecs_task_definition"
  container_name     = var.container_name
  container_image    = var.container_image
  ecs_repository_url = var.ecs_repository_url
  execution_role_arn = var.execution_role_arn
  aws_region         = var.aws_region
}

module "ecs_service" {
  source              = "./modules/ecs_service"
  launch_type = var.launch_type
}