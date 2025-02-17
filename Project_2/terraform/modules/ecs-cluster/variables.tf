variable "cluster_name" {
  description = "The name of the ECS cluster"
  type        = string
}

variable "capacity_providers" {
  description = "The capacity providers for the ECS cluster"
  type        = list(string)
  default     = []
}

variable "tags" {
  description = "Tags to apply to the ECS cluster"
  type        = map(string)
  default     = {}
}