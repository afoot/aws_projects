variable "vpc_id" {
  description = "The ID of the VPC"
  type        = string
  default = module.vpc.aws_vpc.main.id
}

variable "container_port" {
  description = "The port the container listens on"
  type        = number
  default     = module.ecs_task_definition.container_port
}