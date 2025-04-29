output "gw_resource" {
  value = aws_api_gateway_resource.get_db_info.path
}

output "gw_api" {
  value = aws_api_gateway_rest_api.seefood_api.id
}

output "gw_method" {
  value = aws_api_gateway_method.get_all.http_method
}

output "execution_arn" {
  value = "${aws_api_gateway_rest_api.seefood_api.execution_arn}/*/${aws_api_gateway_method.get_all.http_method}/${aws_api_gateway_resource.get_db_info.path_part}"
}

output "api_invoke_url" {
  value = aws_api_gateway_stage.main.invoke_url
}