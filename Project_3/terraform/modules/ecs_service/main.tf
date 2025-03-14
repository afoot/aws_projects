resource "aws_ecs_service" "ecs_service" {
  name            = var.ecs_service_name
  cluster         = var.ecs_cluster_id
  task_definition = var.ecs_task_definition_arn
  desired_count   = var.desired_count
  launch_type     = var.launch_type

  network_configuration {
    subnets          = var.subnet_ids
    security_groups  = [var.security_group_id]
    assign_public_ip = true
  }

  load_balancer {
    target_group_arn = var.target_group_arn
    container_name   = var.container_name
    container_port   = var.container_port
  }
}