terraform {
  # added backend S3 to keep centralized state file
  backend "s3" {
    bucket                   = "terraform-state-bucket-hr"
    key                      = "terraform.tfstate"
    region                   = "us-east-1"
    shared_credentials_files = ["~/.aws/credentials"]
    profile                  = "iamadmin-general"
  }
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.91.0"
    }
  }
}

provider "aws" {
  region                   = "us-east-1"
  shared_credentials_files = ["~/.aws/credentials"]
  profile                  = "iamadmin-general"
}