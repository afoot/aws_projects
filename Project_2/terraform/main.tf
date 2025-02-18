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
}

module "ecr" {
  source               = "./modules/ecr/main.tf"
  ecs_repository_name  = var.ecs_repository_name
  scan_on_push         = var.scan_on_push
  image_tag_mutability = var.image_tag_mutability
}

module "ecs_cluster" {
  source       = "./modules/ecs-cluster"
}

module "ecs_task_definition" {
  source = "./modules/ecs-task-definition"
  ecs_task_definition_family = var.ecs_task_definition_family
  cpu                         = var.cpu
  memory                      = var.memory
  container_name              = var.container_name
  ecr_repository_url          = var.ecr_repository_url
  container_port              = var.container_port
}

module "ecs_service" {
  source              = "./modules/ecs-service"

}