module "vpc" {
  source              = "../../modules/vpc"
  project_name        = var.project_name
  vpc_cidr            = var.vpc_cidr
  azs                 = var.azs
  public_subnet_cidrs = var.public_subnet_cidrs
  private_subnet_cidrs = var.private_subnet_cidrs
}

module "alb_sg" {
  source      = "../../modules/sg"
  name        = "alb-sg"
  description = "Allow HTTP from internet"
  vpc_id      = module.vpc.vpc_id

  ingress_rules = var.alb_sg_ingress
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
