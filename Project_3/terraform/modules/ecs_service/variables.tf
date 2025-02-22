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

variable "launch_type" {
  description = "The launch type for the ECS service"
  type        = string
}

variable "container_name" {
  description = "The name of the container to associate with the service"
  type        = string
  default = "ecs-devops-sandbox-container"
}

variable "container_port" {
  description = "The port of the container to associate with the service"
  type        = number
  default = 80
}

variable "security_group_id" {
  description = "The security group ID for the ALB"
  type        = string
}

variable "subnet_ids" {
  description = "The subnet IDs for the ALB"
  type        = list(string)
}

variable "vpc_id" {
  description = "The VPC ID"
  type        = string
}

variable "ecs_cluster_id" {
  description = "The ID of the ECS cluster"
  type        = string    
 }

variable "ecs_task_definition_arn" {
  description = "value of the task definition ARN"
  type        = string
}

variable "ecs_alb" {
  description = "The ARN of the ALB"
  type        = string
}

variable "target_group_arn" {
  description = "The ARN of the target group"
  type        = string
}