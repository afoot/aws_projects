output "ecr_repository_url" {
  value = aws_ecr_repository.this.repository_url
}

output "ecr_registry_id" {
  value = aws_ecr_repository.this.registry_id
}
