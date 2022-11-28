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

variable "aws_region" {
  type        = string
  description = "AWS Region"
}

variable "aws_cloudwatch_retention_in_days" {
  type        = number
  description = "AWS CloudWatch Logs Retention in Days"
  default     = 1
}


variable "app_private_subnets_id" {
 description = "List of private subnets"
}
variable "public_subnets" {
  description = "List of public subnets"
}

