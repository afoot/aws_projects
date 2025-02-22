variable "ecs_repository_url" {
  description = "The URL of the ECR repository"
  type        = string
}

variable "container_name" {
  description = "The name of the container to associate with the service"
  type        = string
}

variable "container_image" {
  description = "The container image to use for the ECS task"
  type        = string
}

variable "aws_region" {
  description = "The AWS region to deploy to"
  type        = string
}

variable "execution_role_arn" {
  description = "The ARN of the IAM role to use for the ECS task execution role"
  type        = string
}

variable "ecs_task_definition_family" {
  description = "The family name for the ECS task definition"
  type        = string
  default     = "ecs-devops-sandbox-task-definition" 
}

variable "desired_count" {
  description = "The desired number of tasks for the ECS service"
  type        = number
  default     = 1
}

variable "memory" {
  description = "The amount of memory (in MiB) to allocate for the task"
  type        = string
  default = "512"
}

variable "cpu" {
  description = "The number of CPU units to allocate for the task"
  type        = string
  default = "256"
}

variable "network_mode" {
  description = "The subnets to associate with the service"
  type        = string
  default = "awsvpc"
}

variable "container_port" {
  description = "The port of the container to associate with the service"
  type        = number
  default = 80
}

