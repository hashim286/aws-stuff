data "aws_caller_identity" "acct" {}

module "vpc" {
  source         = "./modules/vpc/"
  vpc_cidr_block = var.vpc_cidr_block
  default_region = var.default_region
}

module "security_groups" {
  source = "./modules/security_groups"
  vpc_id = module.vpc.vpc_id
}

module "rds" {
  source          = "./modules/rds/"
  subnet_ids      = module.vpc.subnet_ids
  az              = module.vpc.az
  sec_group_id    = module.security_groups.sec_group_id
  master_password = var.master_password
  master_username = var.master_username
}

module "igw" {
  source = "./modules/igw/"
  vpc_id = module.vpc.vpc_id
}

module "routing" {
  source    = "./modules/routing/"
  vpc_id    = module.vpc.vpc_id
  igw_id    = module.igw.igw_id
  subnet_id = module.vpc.subnet_id
}

module "api_gw" {
  source              = "./modules/api_gw"
  lambda_function_arn = module.lambda.lambda_function_arn
}

module "lambda" {
  source            = "./modules/lambda"
  default_region    = var.default_region
  accountId         = data.aws_caller_identity.acct.account_id
  gw_resource       = module.api_gw.gw_resource
  gw_api            = module.api_gw.gw_api
  gw_method         = module.api_gw.gw_method
  dependencies_file = var.dependencies_file
  execution_arn     = module.api_gw.execution_arn
}


