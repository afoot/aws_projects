resource "aws_ecs_service" "ecs_service" {
  name            = var.ecs_service_name
  cluster         = module.ecs_cluster.cluster_id
  task_definition = module.ecs_task_definition.task_definition_arn
  desired_count   = var.desired_count
  launch_type     = var.launch_type

  network_configuration {
    subnets          = [module.vpc.public_subnets[0], module.vpc.public_subnets[1]]
    security_groups  = [module.aws_security_group.security_group_id]
    assign_public_ip = true
  }

  load_balancer {
    target_group_arn = var.target_group_arn
    container_name   = var.container_name
    container_port   = var.container_port
  }
}