variable "project_name" {
  description = "The name of the project"
  type        = string
}

variable "aws_region" {
  description = "The AWS region where the ECS service will be deployed"
  type        = string
  
}

variable "service_name" {
  description = "The name of the ECS service (e.g., backend, messaging)"
  type        = string
}

variable "cpu" {
  description = "The number of CPU units to allocate to the ECS task"
  type        = number
}

variable "memory" {
  description = "The amount of memory (in MiB) to allocate to the ECS task"
  type        = number
}

variable "image" {
  description = "The container image URI (e.g., from ECR)"
  type        = string
}

variable "container_port" {
  description = "The port on the container to expose"
  type        = number
}

variable "desired_count" {
  description = "The desired number of ECS task instances"
  type        = number
  default     = 1
}

variable "execution_role_arn" {
  description = "ARN of the ECS task execution IAM role"
  type        = string
}

variable "task_role_arn" {
  description = "ARN of the ECS task IAM role"
  type        = string
}

variable "subnet_ids" {
  description = "List of subnet IDs to launch ECS tasks in"
  type        = list(string)
}

variable "security_group_ids" {
  description = "List of security group IDs to associate with the ECS service"
  type        = list(string)
}

variable "target_group_arn" {
  description = "ARN of the ALB target group for the ECS service"
  type        = string
}

variable "listener_rule_arn" {
  description = "ARN of the ALB target group for the ECS service"
  type        = string
}

