output "rds_url" {
  value = module.rds.rds_url
}

output "account_id" {
  value = data.aws_caller_identity.acct.id
}

output "api_gw_invoke_url" {
  value = module.api_gw.api_invoke_url
}