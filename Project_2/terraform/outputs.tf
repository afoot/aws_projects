resource "aws_ecr_repository" "this" {
  name = var.ecr_repository_name
}

output "repository_uri" {
  value = aws_ecr_repository.this.repository_url
}