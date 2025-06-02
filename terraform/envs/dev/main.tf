module "vpc" {
  source               = "../../modules/vpc"
  project_name         = var.project_name
  vpc_cidr             = var.vpc_cidr
  azs                  = var.azs
  public_subnet_cidrs  = var.public_subnet_cidrs
  private_subnet_cidrs = var.private_subnet_cidrs
}

module "alb_sg" {
  source        = "../../modules/sg"
  name          = "alb-sg"
  description   = "Allow traffic from ALB"
  vpc_id        = module.vpc.vpc_id
  ingress_rules = var.alb_sg_ingress
  egress_rules  = var.alb_sg_egress
}

// Uncomment this block if you need an RDS security group

# module "rds_sg" {
#   source        = "../../modules/sg"
#   name          = "rds-sg"
#   description   = "Allow DB traffic from RDS"
#   vpc_id        = module.vpc.vpc_id
#   ingress_rules = var.rds_sg_ingress
#   egress_rules  = var.rds_sg_egress
# }

module "backend_ecr" {
  source          = "../../modules/ecr"
  repository_name = "backend-service"
  tags = {
    Environment = "dev"
    Service     = "backend"
  }
}

module "messaging_ecr" {
  source          = "../../modules/ecr"
  repository_name = "messaging-service"
  tags = {
    Environment = "dev"
    Service     = "messaging"
  }
}

module "ecs_iam_roles" {
  source       = "../../modules/iam"
  project_name = var.project_name
}

module "alb" {
  source = "../../modules/alb"

  project_name           = var.project_name
  vpc_id                 = module.vpc.vpc_id
  public_subnet_ids      = module.vpc.public_subnets
  alb_security_group_ids = [module.alb_sg.security_group_id]

  alb_sg_ingress = var.alb_sg_ingress
  alb_sg_egress  = var.alb_sg_egress

  backend_target_port   = var.backend_container_port
  messaging_target_port = var.messaging_container_port

}


module "backend_ecs" {
  source             = "../../modules/ecs"
  project_name       = var.project_name
  aws_region         = var.aws_region
  service_name       = "backend"
  cpu                = var.backend_cpu
  memory             = var.backend_memory
  image              = var.backend_image
  container_port     = var.backend_container_port
  desired_count      = var.backend_desired_count
  execution_role_arn = var.backend_ecs_execution_role_arn
  task_role_arn      = var.backend_ecs_task_role_arn
  subnet_ids         = module.vpc.private_subnets
  security_group_ids = [module.alb_sg.security_group_id]
  target_group_arn   = module.alb.backend_target_group_arn
  listener_rule_arn  = module.alb.backend_listener_rule_arn
}


module "messaging_ecs" {
  source             = "../../modules/ecs"
  project_name       = var.project_name
  aws_region         = var.aws_region
  service_name       = "messaging"
  cpu                = var.messaging_cpu
  memory             = var.messaging_memory
  image              = var.messaging_image
  container_port     = var.messaging_container_port
  desired_count      = var.messaging_desired_count
  execution_role_arn = var.messaging_ecs_execution_role_arn
  task_role_arn      = var.messaging_ecs_task_role_arn
  subnet_ids         = module.vpc.private_subnets
  security_group_ids = [module.alb_sg.security_group_id]
  target_group_arn   = module.alb.messaging_target_group_arn
  listener_rule_arn  = module.alb.messaging_listener_rule_arn
}







