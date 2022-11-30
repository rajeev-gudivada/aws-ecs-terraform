# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# CREATE AN S3 BUCKET AND DYNAMODB TABLE TO USE AS A TERRAFORM BACKEND
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


terraform {
  # This module is now only being tested with Terraform 1.1.x. However, to make upgrading easier, we are setting 1.0.0 as the minimum version.
  required_version = ">= 1.0.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "< 4.0"
    }
  }
}

# ------------------------------------------------------------------------------
# CONFIGURE OUR AWS CONNECTION
# ------------------------------------------------------------------------------

provider "aws" {
  region = "us-east-1"
  default_tags {
    tags = {
      "om:owner"        = "ONE Muthoot"
      "om:cost-center"  = "ONE Muthoot"
      "om:project-name" = "ONE Muthoot Super Application"
      "om:environment"  = "Staging"

    }
  }
}


# ------------------------------------------------------------------------------
# configuring the backend
# ------------------------------------------------------------------------------

terraform {
  backend "s3" {
    bucket         = "om-terraform-state-1121"
    key            = "terraform/backend/stage-tfstate"
    region         = "us-east-1"
    dynamodb_table = "om-terraform-lock"
    encrypt        = true
  }
}
