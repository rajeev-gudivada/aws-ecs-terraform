variable "app_environment" {
  description = "The Deployment environment"
}

variable "app_name" {
  type        = string
  description = "Application Name"
}

variable "vpc_id" {
  description = "The name of the vpc  in which the resources will be created"
}

variable "public_subnets_id" {
  description = "List of public subnets"
}

variable "bastion_public_key_path" {
  description = "path to  bastion public key"
}

variable "bastion_private_key_path" {
  description = "path to bastion private key"
}
