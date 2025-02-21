variable "aws_region" {
  description = "AWS region"
  type        = string
}

variable "vpc_cidr" {
  description = "CIDR block for VPC"
  type        = string
}

variable "ecs_cluster_name" {
  description = "The name of the ECS cluster"
  type        = string
}

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

variable "execution_role_arn" {
  description = "The ARN of the IAM role to use for the ECS task execution role"
  type        = string
}