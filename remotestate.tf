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
}

# creating key to encrypt terraform state bucket objects
resource "aws_kms_key" "terraform_state_bucket_key" {
  description             = "This key is used to encrypt bucket objects"
  deletion_window_in_days = 10
}
# ------------------------------------------------------------------------------
# CREATE THE S3 BUCKET
# ------------------------------------------------------------------------------

resource "aws_s3_bucket" "terraform_state_bucket" {
  # TODO: change this to your own name! S3 bucket names must be *globally* unique.
  bucket = "om-terraform-state-1121"
}
# ------------------------------------------------------------------------------
# Enable versioning so we can see the full revision history of our
# state files
# ------------------------------------------------------------------------------
resource "aws_s3_bucket_versioning" "enable_versioning" {
  bucket = aws_s3_bucket.terraform_state_bucket.id
  versioning_configuration {
    status = "Enabled"
  }
}
# ------------------------------------------------------------------------------
# Enable server-side encryption for the bucket
# ------------------------------------------------------------------------------

resource "aws_s3_bucket_server_side_encryption_configuration" "terraform_state_bucket_encryption" {
  bucket = aws_s3_bucket.terraform_state_bucket.bucket

  rule {
    apply_server_side_encryption_by_default {
      kms_master_key_id = aws_kms_key.terraform_state_bucket_key.arn
      sse_algorithm     = "aws:kms"
    }
  }
}
# ------------------------------------------------------------------------------
# CREATE THE DYNAMODB TABLE
# ------------------------------------------------------------------------------

resource "aws_dynamodb_table" "terraform_lock" {
  name         = "om-terraform-lock"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }
}
