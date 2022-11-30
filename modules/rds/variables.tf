variable "vpc_id" {
  description = "The name of the vpc  in which the resources will be created"
}

variable "app_environment" {
  description = "The Deployment environment"
}

variable "app_name" {
  type        = string
  description = "Application Name"
}

variable "persistence_private_subnets_id" {
  description = "Persistence private subnets"
}

variable "ecs_sg" {
  description = "ecs sg id"
}

variable "db_username" {
  description = "mysql db master user, provide through secrets.tfvars file "
  type        = string
  sensitive   = true
}


variable "db_password" {
  description = "mysql db master password, provide through secrets.tfvars file "
  type        = string
  sensitive   = true
}