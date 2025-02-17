variable "cluster_name" {
  description = "The name of the ECS cluster"
  type        = string
}

variable "service_name" {
  description = "The name of the ECS service"
  type        = string
}

variable "task_definition" {
  description = "The task definition to use for the ECS service"
  type        = string
}

variable "desired_count" {
  description = "The desired number of tasks to run in the ECS service"
  type        = number
  default     = 1
}

variable "subnet_ids" {
  description = "The subnet IDs for the ECS service"
  type        = list(string)
}

variable "security_group_ids" {
  description = "The security group IDs for the ECS service"
  type        = list(string)
}

variable "cluster_id" {
  description = "The ID or ARN of the ECS cluster"
  type        = string
}