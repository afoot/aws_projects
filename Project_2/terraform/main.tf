# This file is the main entry point for the terraform configuration. 
# It defines the modules that will be used to create the infrastructure.

module "vpc" {
  source = "./modules/vpc"
}

module "security" {
  source         = "./modules/security"
}

module "iam" {
  source = "./modules/iam"
  ecs_repository_name = var.ecs_repository_name
}

module "ecr" {
  source               = "./modules/ecr"
}

module "ecs_cluster" {
  source       = "./modules/ecs-cluster"
}

module "ecs_task_definition" {
  source = "./modules/ecs-task-definition"
  cpu = var.cpu
  container_image = var.container_image
  memory = var.memory
  container_name = var.container_name
  aws_region = var.aws_region
  ecs_repository_url = var.ecs_repository_url
}

module "ecs_service" {
  source             = "./modules/ecs-service"
  task_definition_arn = var.task_definition_arn
  target_group_arn    = var.target_group_arn
  cluster_id          = var.cluster_id
  container_port      = var.container_port
  subnet_ids          = var.subnet_ids
  container_name      = var.container_name
}