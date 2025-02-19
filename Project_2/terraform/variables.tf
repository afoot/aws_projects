# Define the variables that will be used in the Terraform configuration.
variable "account_id" {
  description = "The AWS account ID"
  type        = string

}

variable "ecs_repository_name" {
  description = "The name of the ECR repository"
  type        = string
  default     = "ecs-devops-sandbox-repository"
}

variable "ecs_repository_url" {
  description = "The URL of the ECR repository"
  type        = string
}

variable "container_name" {
  description = "The name of the container to associate with the service"
  type        = string
  default     = "ecs-devops-sandbox-container"

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

variable "container_port" {
  description = "The port on which the container is listening"
  type        = number
  default     = 8080
}

variable "image_tag_mutability" {
  description = "Specifies whether to allow image tags to be mutable. If set to 'MUTABLE', tags can be overwritten."
  type        = string
}

variable "scan_on_push" {
  description = "Specifies whether to scan images on push."
  type        = bool
}

variable "vpc_id" {
  description = "The ID of the VPC"
  type        = string
}

variable "task_definition_arn" {
  description = "The ARN of the task definition"
  type        = string
}

variable "cluster_id" {
  description = "The ID of the ECS cluster"
  type        = string
}

variable "subnet_ids" {
  description = "The subnet IDs to associate with the service"
  type        = list(string)
}

