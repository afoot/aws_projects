output "vpc_id" {
  value = module.vpc.vpc_id
}

output "public_subnet_ids" {
  value = module.vpc.public_subnet_ids
}

output "private_subnet_ids" {
  value = module.vpc.private_subnet_ids
}

output "ecr_repository_url" {
  value = module.ecr.repository_url
}

output "ecs_cluster_id" {
  value = module.ecs_cluster.cluster_id
}

output "ecs_task_definition_arn" {
  value = module.ecs_task_definition.task_definition_arn
}

output "ecs_service_name" {
  value = module.ecs_service.service_name
}