
output "vpc_id" {
  value = module.vpc.vpc_id
}

output "public_subnet_ids" {
  value = module.vpc.public_subnet_ids
}

output "private_subnet_ids" {
  value = module.vpc.private_subnet_ids
}

output "ecs_cluster_id" {
  value = module.ecs-cluster.cluster_id
}

output "ecs_cluster_arn" {
  value = module.ecs-cluster.ecs_cluster_arn
}

output "ecs_task_definition_arn" {
  value = module.ecs-task-definition.task_definition_arn
}

output "ecs_service_name" {
  value = module.ecs-service.ecs_service_name
}