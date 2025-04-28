#data "aws_iam_policy_document" "seefood-query-assume-role" {
#	file("${path.module}/trust.json")
#}
#
#data "aws_iam_policy_document" "seefood-query-access" {
#	file("${path.module}/perms.json")
#}

resource "aws_iam_policy" "seefood-query-perms" {
  name   = "seefood-query-perms"
  policy = file("${path.module}/perms.json")
}

resource "aws_iam_role" "seefood-query-role" {
  name               = "seefood-query-role"
  assume_role_policy = file("${path.module}/trust.json")
}

resource "aws_iam_role_policy_attachment" "seefood-query-role-attachment" {
  role       = aws_iam_role.seefood-query-role.id
  policy_arn = aws_iam_policy.seefood-query-perms.arn
}

resource "aws_lambda_function" "seefood-query" {
  filename      = "dependencies_v3.zip"
  function_name = "seefood-query"
  runtime       = "python3.12"
  role          = aws_iam_role.seefood-query-role.arn
  handler       = "lambda_function.py"
}

resource "aws_lambda_permission" "apigw_lambda" {
  statement_id  = "AllowExecutionFromLambda"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.seefood-query
  principal     = "apigateway.amazonaws.com"
  source_arn    = "arn:aws:execute-api:${var.default_region}:${var.accountId}:${aws_api_gateway_rest_api.seefood_api.id}/*/${aws_api_gateway_method.get_all.http_method}${aws_api_gateway_resource.get_db_info.path}"
}
