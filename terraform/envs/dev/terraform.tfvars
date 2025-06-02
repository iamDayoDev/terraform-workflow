project_name         = "workmate-dev"
aws_region           = "us-east-1"
vpc_cidr             = "10.0.0.0/16"
azs                  = ["us-east-1a", "us-east-1b"]
public_subnet_cidrs  = ["10.0.1.0/24", "10.0.2.0/24"]
private_subnet_cidrs = ["10.0.3.0/24", "10.0.4.0/24"]


alb_sg_ingress = [
  {
    description     = "Allow HTTP from internet"
    from_port       = 80
    to_port         = 80
    protocol        = "tcp"
    cidr_blocks     = ["0.0.0.0/0"]
    security_groups = []
  }
]

alb_sg_egress = [
  {
    description = "Allow all outbound"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
]

rds_sg_ingress = [
  {
    description     = "Allow PostgreSQL"
    from_port       = 5432
    to_port         = 5432
    protocol        = "tcp"
    cidr_blocks     = []
    security_groups = [] # Set dynamically if needed
  }
]

rds_sg_egress = [
  {
    description = "Allow all outbound"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
]

# Backend service variables
backend_cpu                    = "256"
backend_memory                 = "512"
backend_image                  = "415309296505.dkr.ecr.us-east-1.amazonaws.com/backend-service:latest"
backend_container_port         = 3000
backend_desired_count          = 1
backend_ecs_execution_role_arn = "arn:aws:iam::415309296505:role/backendEcsExecutionRole"
backend_ecs_task_role_arn      = "arn:aws:iam::415309296505:role/backendEcsTaskRole"


# Messaging service variables
messaging_cpu                    = "512"
messaging_memory                 = "1024"
messaging_image                  = "415309296505.dkr.ecr.us-east-1.amazonaws.com/messaging-service:latest"
messaging_container_port         = 4000
messaging_desired_count          = 1
messaging_ecs_execution_role_arn = "arn:aws:iam::415309296505:role/messagingEcsExecutionRole"
messaging_ecs_task_role_arn      = "arn:aws:iam::415309296505:role/messagingEcsTaskRole"


