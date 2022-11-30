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

variable "dbuser" {
  description = "my sql db user"
  sensitive   = true
  default     = "omdbuser"
}


variable "dbpassword" {
  description = "my sql db password, provide through your ENV variables"
  sensitive   = true
  default     = "omdbpassword"
}