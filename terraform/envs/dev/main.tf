module "vpc" {
  source              = "../../modules/vpc"
  project_name        = "backend-test"
  vpc_cidr            = "10.0.0.0/16"
  azs                 = ["us-east-1a", "us-east-1b"]
  public_subnet_cidrs = ["10.0.1.0/24", "10.0.2.0/24"]
  private_subnet_cidrs = ["10.0.3.0/24", "10.0.4.0/24"]
}

module "alb_sg" {
  source      = "../../modules/sg"
  name        = "alb-sg"
  description = "Allow HTTP from internet"
  vpc_id      = module.vpc.vpc_id

  ingress_rules = [
    {
      description = "Allow HTTP"
      from_port   = 80
      to_port     = 80
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  ]
}

module "ecs_sg" {
  source      = "../../modules/sg"
  name        = "ecs-sg"
  description = "Allow traffic from ALB"
  vpc_id      = module.vpc.vpc_id

  ingress_rules = [
    {
      description     = "Allow from ALB"
      from_port       = 3000
      to_port         = 3000
      protocol        = "tcp"
      cidr_blocks     = []
      security_groups = [module.alb_sg.security_group_id]
    }
  ]
}

module "rds_sg" {
  source      = "../../modules/sg"
  name        = "rds-sg"
  description = "Allow DB traffic from ECS"
  vpc_id      = module.vpc.vpc_id

  ingress_rules = [
    {
      description     = "Allow PostgreSQL"
      from_port       = 5432
      to_port         = 5432
      protocol        = "tcp"
      cidr_blocks     = []
      security_groups = [module.ecs_sg.security_group_id]
    }
  ]
}
