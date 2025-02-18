variable "ecs_repository_name" {
  description = "The name of the ECR repository"
  type        = string
  default     = "ecs-devops-sandbox-repository"
 }

variable "scan_on_push" {
  description = "Whether to scan images on push"
  type        = bool
  default     = false
 }

variable "image_tag_mutability" {
  description = "The mutability of the image tags"
  type        = string
  default     = "MUTABLE"
 }
 