variable "task_definition_name" {
  description = "The name of the ECS task definition"
  type        = string
}

variable "container_image" {
  description = "The Docker image to use for the container"
  type        = string
}

variable "cpu" {
  description = "The amount of CPU to allocate for the task"
  type        = string
  default     = "256"
}

variable "memory" {
  description = "The amount of memory to allocate for the task"
  type        = string
  default     = "512"
}

variable "port_mappings" {
  description = "The port mappings for the container"
  type        = list(object({
    container_port = number
    host_port      = number
    protocol       = string
  }))
  default = [
    {
      container_port = 8080
      host_port      = 8080
      protocol       = "tcp"
    }
  ]
}

variable "execution_role_arn" {
  description = "The ARN of the IAM role that the ECS task can assume"
  type        = string
}

variable "task_role_arn" {
  description = "The ARN of the IAM role that the ECS task can assume"
  type        = string
  default     = ""
}