resource "random_id" "random_id_prefix" {
  byte_length = 2
}
/*====
Variables used across all modules
======*/
locals {
  stage_availability_zones = ["${var.region}a", "${var.region}b", "${var.region}c"]
  availability_zones       = ["${var.region}a", "${var.region}b", "${var.region}c"]
}


module "networking" {
  source = "../../modules/networking"

  region                           = var.region
  environment                      = var.environment
  vpc_cidr                         = var.vpc_cidr
  public_subnets_cidr              = var.public_subnets_cidr
  app_private_subnets_cidr         = var.app_private_subnets_cidr
  persistence_private_subnets_cidr = var.persistence_private_subnets_cidr
  availability_zones               = local.availability_zones
}



module "ecs" {
  source = "../../modules/ecs"

  app_environment        = var.environment
  app_name               = var.app
  aws_region             = var.region
  vpc_id                 = module.networking.vpc_id
  public_subnets         = module.networking.public_subnets_id
  app_private_subnets_id = module.networking.app_private_subnets_id

}

module "rds" {
  source = "../../modules/rds"

  app_environment                = var.environment
  app_name                       = var.app
  vpc_id                         = module.networking.vpc_id
  persistence_private_subnets_id = module.networking.persistence_private_subnets_id
  ecs_sg                         = module.ecs.ecs_sg
}