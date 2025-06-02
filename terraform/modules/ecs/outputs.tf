
output "cluster_name" {
  description = "Name of the ECS Cluster"
  value       = aws_ecs_cluster.ecs-cluster.name
}

output "service_name" {
  description = "Name of the ECS Service"
  value       = aws_ecs_service.ecs-service.name
}

