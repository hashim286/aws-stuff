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
  filename      = var.dependencies_file
  function_name = "seefood-query"
  runtime       = "python3.12"
  role          = aws_iam_role.seefood-query-role.arn
  handler       = "lambda_function.lambda_handler"
  timeout       = 60
}

resource "aws_lambda_permission" "apigw_lambda_get_query" {
  statement_id  = "AllowExecutionFromLambda"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.seefood-query.function_name
  principal     = "apigateway.amazonaws.com"
  source_arn    = var.execution_arn
}
