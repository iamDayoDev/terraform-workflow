variable "project_name" {
  type        = string
  description = "Project name prefix"
}
variable "aws_region" {
  type        = string
  description = "AWS region"
}

variable "vpc_cidr" {
  type        = string
  description = "CIDR block for the VPC"
}

variable "azs" {
  type        = list(string)
  description = "Availability zones"
}

variable "public_subnet_cidrs" {
  type        = list(string)
  description = "Public subnet CIDRs"
}

variable "private_subnet_cidrs" {
  type        = list(string)
  description = "Private subnet CIDRs"
}

variable "alb_sg_ingress" {
  type = list(object({
    description = string
    from_port   = number
    to_port     = number
    protocol    = string
    cidr_blocks = list(string)
  }))
}

variable "alb_sg_egress" {
  description = "Egress rules for ECS"
  type = list(object({
    description = string
    from_port   = number
    to_port     = number
    protocol    = string
    cidr_blocks = list(string)
  }))
}


variable "rds_sg_ingress" {
  type = list(object({
    description     = string
    from_port       = number
    to_port         = number
    protocol        = string
    cidr_blocks     = list(string)
    security_groups = list(string)
  }))
}

variable "rds_sg_egress" {
  description = "Egress rules for ECS"
  type = list(object({
    description = string
    from_port   = number
    to_port     = number
    protocol    = string
    cidr_blocks = list(string)
  }))
}

# Tags
variable "tags" {
  description = "Common tags applied to all resources"
  type        = map(string)
  default = {
    Environment = "dev"
    Project     = "workmate-dev"
    Owner       = "Adedayo"
  }
}

# Backend service variables
variable "backend_cpu" {
  type = number
}

variable "backend_memory" {
  type = number
}

variable "backend_image" {
  type = string
}

variable "backend_container_port" {
  type = number
}

variable "backend_desired_count" {
  type = number
}

variable "backend_ecs_execution_role_arn" {
  type = string
}

variable "backend_ecs_task_role_arn" {
  type = string
}


# Messaging service variables
variable "messaging_cpu" {
  type = number
}

variable "messaging_memory" {
  type = number
}

variable "messaging_image" {
  type = string
}

variable "messaging_container_port" {
  type = number
}

variable "messaging_desired_count" {
  type = number
}

variable "messaging_ecs_execution_role_arn" {
  type = string
}

variable "messaging_ecs_task_role_arn" {
  type = string
}




