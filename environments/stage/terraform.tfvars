//AWS 
region      = "us-east-1"
environment = "stage"
app         = "om"
/* module networking */
vpc_cidr                         = "10.0.0.0/16"
public_subnets_cidr              = ["10.0.16.0/20", "10.0.64.0/20"] //List of Public subnet cidr range
app_private_subnets_cidr         = ["10.0.32.0/20", "10.0.96.0/20"] //List of app private subnet cidr range
persistence_private_subnets_cidr = ["10.0.48.0/20", "10.0.80.0/20"] //List of persistence private subnet cidr range
