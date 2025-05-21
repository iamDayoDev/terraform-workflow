module "vpc" {
  source               = "../../modules/vpc"
  project_name         = var.project_name
  vpc_cidr             = var.vpc_cidr
  azs                  = var.azs
  public_subnet_cidrs  = var.public_subnet_cidrs
  private_subnet_cidrs = var.private_subnet_cidrs
}

module "alb_sg" {
  source      = "../../modules/sg"
  name        = "alb-sg"
  description = "Allow HTTP from internet"
  vpc_id      = module.vpc.vpc_id

  ingress_rules = [
    {
      description     = "Allow HTTP from internet"
      from_port       = 80
      to_port         = 80
      protocol        = "tcp"
      cidr_blocks     = ["0.0.0.0/0"]
      security_groups = []
    }
  ]
}

module "ecs_sg" {
  source      = "../../modules/sg"
  name        = "ecs-sg"
  description = "Allow traffic from ALB"
  vpc_id      = module.vpc.vpc_id
  ingress_rules  = var.alb_sg_ingress
  egress_rules   = var.alb_sg_egress
}

module "ecs_sg" {
  source      = "../../modules/sg"
  name        = "ecs-sg"
  description = "Allow traffic from ALB"
  vpc_id      = module.vpc.vpc_id
  ingress_rules  = var.ecs_sg_ingress
  egress_rules   = var.ecs_sg_egress
}

module "rds_sg" {
  source      = "../../modules/sg"
  name        = "rds-sg"
  description = "Allow DB traffic from ECS"
  vpc_id      = module.vpc.vpc_id
  ingress_rules  = var.rds_sg_ingress
  egress_rules   = var.rds_sg_egress
}
