output "repository_url" {
  value = aws_ecr_repository.image-repository.repository_url
}

output "repository_name" {
  value = aws_ecr_repository.image-repository.name
}
