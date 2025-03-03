variable "aws_region" {
  description = "The AWS region to deploy to"
  type        = string
  default     = "us-east-1"
}

variable "aws_key" {
  description = "The name of the SSH key to use"
  type        = string
}