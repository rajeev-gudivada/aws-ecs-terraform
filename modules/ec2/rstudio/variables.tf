# define the local IP to map to the SSH security rule
#variable "local_ip" {
#  type = "string"
#}

# pass the region as a variable so we can provide it in a tfvars file
variable "region" {
  type = string
}


variable "vpc_id" {
  type = string
}

variable "app_environment" {
  description = "The Deployment environment"
}

variable "app_name" {
  type        = string
  description = "Application Name"
} 

# define the region specific rstudio images
variable "images" {
  type = map

  default = {
    "ap-south-1"      = "ami-0136f51bfeac09417"
  }
}

variable "instance_type" {
  type    = string
  default = "t2.micro"
}

variable "persistence_private_subnets_id" {
}

#variable "keypair_name" {
#  type = "string"
#}

#variable "private_key" {
#  type = "string"
#}

#variable "rstudio_password" {
#  type = "string"
#}

variable "disk_size" {
  type    = string
  default = "40"
}

variable "keep_data" {
  type    = string
  default = "yes"
}


variable "alb_arn" {
  type = string
}