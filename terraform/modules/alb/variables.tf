
variable "project_name" {
  description = "Name prefix for ALB and related resources"
  type        = string
}

variable "vpc_id" {
  description = "VPC ID where the ALB will be deployed"
  type        = string
}

variable "public_subnet_ids" {
  description = "List of public subnet IDs for the ALB"
  type        = list(string)
}

variable "alb_security_group_ids" {
  description = "Security group IDs for the ALB"
  type        = list(string)
}

variable "alb_sg_ingress" {
  description = "List of ingress rules for the ALB security group"
  type = list(object({
    description     = string
    from_port       = number
    to_port         = number
    protocol        = string
    cidr_blocks     = list(string)
    security_groups = optional(list(string), [])
  }))
}

variable "alb_sg_egress" {
  description = "List of egress rules for the ALB security group"
  type = list(object({
    description = string
    from_port   = number
    to_port     = number
    protocol    = string
    cidr_blocks = list(string)
  }))
}


variable "backend_target_port" {
  description = "Container port for the messaging service target group"
  type        = number
  default     = 3000
}

variable "messaging_target_port" {
  description = "Container port for the messaging service target group"
  type        = number
  default     = 4000
}

variable "health_check_path" {
  description = "Health check path for the target groups"
  type        = string
  default     = "/health"
}

variable "health_check_interval" {
  type        = number
  description = "Interval between health checks"
  default     = 30
}

variable "health_check_timeout" {
  type        = number
  description = "Timeout for each health check"
  default     = 5
}

variable "healthy_threshold" {
  type        = number
  description = "Number of consecutive successful checks to mark healthy"
  default     = 2
}

variable "unhealthy_threshold" {
  type        = number
  description = "Number of consecutive failures to mark unhealthy"
  default     = 2
}

variable "health_check_matcher" {
  type        = string
  description = "HTTP code matcher for success"
  default     = "200"
}
