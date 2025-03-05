variable "aws_region" {
  description = "The AWS region to deploy to"
  type        = string
  default     = "us-east-1"
}

variable "ecr_repo_name" {
  description = "The ECR repository name"
  type        = string
}