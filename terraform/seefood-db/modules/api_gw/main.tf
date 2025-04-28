resource "aws_api_gateway_rest_api" "seefood_api" {
  name        = "seefood-api"
  description = "seefood api"
}

resource "aws_api_gateway_resource" "get_db_info" {
  rest_api_id = aws_api_gateway_rest_api.seefood_api.id
  parent_id   = aws_api_gateway_rest_api.seefood_api.root_resource_id
  path_part  = "query"
}

resource "aws_api_gateway_method" "get_all" {
  rest_api_id   = aws_api_gateway_rest_api.seefood_api.id
  resource_id   = aws_api_gateway_resource.get_db_info.id
  http_method   = "GET"
  authorization = "NONE"
}


resource "aws_api_gateway_integration" "call_lambda_seefood" {
  rest_api_id             = aws_api_gateway_rest_api.seefood_api.id
  resource_id             = aws_api_gateway_resource.get_db_info.id
  http_method             = aws_api_gateway_method.get_all.http_method
  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = var.lambda_function_arn
}

