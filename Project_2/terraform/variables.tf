variable "ecr_repository_name" {
  description = "The name of the ECR repository"
  type        = string
  default     = "ecs-devops-sandbox-repository"
}

variable "ecs_cluster_name" {
  description = "The name of the ECS cluster"
  type        = string
  default     = "ecs-devops-sandbox-cluster"
}

variable "ecs_task_definition_family" {
  description = "The family name for the ECS task definition"
  type        = string
  default     = "ecs-devops-sandbox-task-definition"
}

variable "ecs_service_name" {
  description = "The name of the ECS service"
  type        = string
  default     = "ecs-devops-sandbox-service"
}

variable "desired_count" {
  description = "The desired number of tasks for the ECS service"
  type        = number
  default     = 1
}

variable "container_image" {
  description = "The container image to use for the ECS task"
  type        = string
}

variable "memory" {
  description = "The amount of memory (in MiB) to allocate for the task"
  type        = string
}

variable "cpu" {
  description = "The number of CPU units to allocate for the task"
  type        = string
}

variable "region" {
  description = "The AWS region to deploy to"
  type        = string
  default     = "us-east-1"
}

variable "subnets" {
  description = "The subnets to associate with the service"
  type        = list(string)
}

variable "security_groups" {
  description = "The security groups to associate with the service"
  type        = list(string)
}

variable "assign_public_ip" {
  description = "Whether to assign a public IP address to the service"
  type        = bool
  default     = true
}

variable "target_group_arn" {
  description = "The ARN of the target group"
  type        = string
}