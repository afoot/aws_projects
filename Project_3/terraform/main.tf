
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
  source                  = "./modules/ecs_service"
  launch_type             = var.launch_type
  subnet_ids              = module.vpc.public_subnets
  security_group_id       = module.security.security_group_id
  vpc_id                  = module.vpc.vpc_id
  ecs_cluster_id          = module.ecs_cluster.ecs_cluster_id
  ecs_task_definition_arn = module.ecs_task_definition.ecs_task_definition_arn
  ecs_alb                 = module.ecs_alb.ecs_alb_arn
  target_group_arn        = module.ecs_alb.target_group_arn
}

module "security" {
  source = "./modules/security"
  vpc_id = module.vpc.vpc_id
}

module "ecs_alb" {
  source            = "./modules/ecs_alb"
  vpc_id            = module.vpc.vpc_id
  security_group_id = module.security.security_group_id
  subnet_ids = [
    module.vpc.public_subnets[0],
    module.vpc.public_subnets[1],
    module.vpc.public_subnets[2]
  ]
}