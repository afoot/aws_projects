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

variable "aws_region" {
  description = "The AWS region to deploy to"
  type        = string
}

variable "network_mode" {
  description = "The subnets to associate with the service"
  type        = string
  default = "awsvpc"
}

variable "container_name" {
  description = "The name of the container to associate with the service"
  type        = string
}

variable "container_port" {
  description = "The port of the container to associate with the service"
  type        = number
  default = 8080
}

variable "ecs_repository_url" {
  description = "The URL of the ECR repository"
  type        = string
  default = module.ecr.aws_ecr_repository.this.repository_url
}