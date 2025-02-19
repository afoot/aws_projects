output "cluster_id" {
  description = "The ID of the ECS cluster"
  value       = aws_ecs_cluster.this.id
}
output "ecs_cluster_arn" {
  value = aws_ecs_cluster.this.arn
}
