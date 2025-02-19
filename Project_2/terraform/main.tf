# This file is the main entry point for the terraform configuration. 
# It defines the modules that will be used to create the infrastructure.

module "vpc" {
  source = "./modules/vpc"
}

module "security" {
  source         = "./modules/security"
  vpc_id         = module.vpc.vpc_id
  container_port = var.container_port
}

module "iam" {
  source              = "./modules/iam"
  ecs_repository_name = var.ecs_repository_name
  account_id          = var.account_id
}


module "ecs-cluster" {
  source = "./modules/ecs-cluster"
}

module "ecs-task-definition" {
  source             = "./modules/ecs-task-definition"
  cpu                = var.cpu
  container_image    = var.container_image
  memory             = var.memory
  container_name     = var.container_name
  aws_region         = var.aws_region
  ecs_repository_url = var.ecs_repository_url
  execution_role_arn = module.iam.ecs_task_execution_role_arn
}

module "ecs-service" {
  source              = "./modules/ecs-service"
  cluster_id          = module.ecs-cluster.cluster_id
  task_definition_arn = module.ecs-task-definition.task_definition_arn
  subnet_ids          = module.vpc.private_subnet_ids
  security_group_ids  = [module.security.ecs_tasks_security_group_id]
  target_group_arn    = var.target_group_arn
  container_name      = var.container_name
  container_port      = var.container_port
}