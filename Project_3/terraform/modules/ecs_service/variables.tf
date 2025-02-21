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

variable "subnet_ids" {
  description = "The subnet IDs to associate with the service"
  type        = list(string)
}

variable "container_name" {
  description = "The name of the container to associate with the service"
  type        = string
}

variable "container_port" {
  description = "The port of the container to associate with the service"
  type        = number
}

variable "target_group_arn" {
  description = "The ARN of the target group"
  type        = string
}


variable "security_group_ids" {
  description = "The security groups to associate with the service"
  type        = list(string)
}