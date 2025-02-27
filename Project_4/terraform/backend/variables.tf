variable "container_port" {
  description = "Container port"
  type        = number
}

variable "container_image" {
  description = "Container image"
  type        = string
}

variable "aws_region" {
  description = "AWS region to deploy resources"
  type        = string
}
