terraform {
  # added backend S3 to keep centralized state file
  backend "s3" {
    bucket                   = "BUCKET_NAME"
    key                      = "KEY"
    region                   = "DEFAULT_REGION"
    shared_credentials_files = ["CREDENTIALS_PATH"]
    profile = "IF_APPLICABLE"
  }
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.91.0"
    }
  }
}

provider "aws" {
  region                   = "DEFAULT_REGION"
  shared_credentials_files = ["CREDENTIALS_PATH"]
}