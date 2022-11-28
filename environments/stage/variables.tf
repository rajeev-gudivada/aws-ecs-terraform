variable "region" {
  description = "us-east-1"
}

variable "environment" {
  description = "The Deployment environment"
}

variable "app" {
  description = "The Application name"
}

//Networking
variable "vpc_cidr" {
  description = "The CIDR block of the vpc"
}

variable "public_subnets_cidr" {
  type        = list(any)
  description = "The CIDR block for the public subnet"
}

variable "app_private_subnets_cidr" {
  type        = list(any)
  description = "The CIDR block for the app private subnet"
}

variable "persistence_private_subnets_cidr" {
  type        = list(any)
  description = "The CIDR block for the persistence private subnet"
}