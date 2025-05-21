project_name         = "workmate-dev"
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

ecs_sg_ingress = [
  {
    description     = "Allow from ALB"
    from_port       = 3000
    to_port         = 3000
    protocol        = "tcp"
    cidr_blocks     = []
    security_groups = [] # Set dynamically if needed
  }
]

ecs_sg_egress = [
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