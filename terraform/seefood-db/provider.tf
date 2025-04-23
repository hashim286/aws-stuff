terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.91.0"
    }
  }
}

provider "aws" {
  region                   = var.default_region
  shared_credentials_files = [var.creds_file_path]
}
