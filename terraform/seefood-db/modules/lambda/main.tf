data "aws_iam_policy_document" "seefood-query-assume-role" {
    statement {
        effect = "Allow"

    principals {
        type = "Service"
        identifiers = ["lambda.amazonaws.com"]
    }
    
    actions = ["sts:AssumeRole"]
    
    }
}

data "aws_iam_policy_document" "seefood-query-access" {
    statement {
        sid = "allow-lambda-access"
        actions = [
            "logs:CreateLogGroup",
        ]

        resources = ["arn:aws:logs:us-east-1:891612549533:*"]
    }
}

resource "aws_iam_policy" "seefood-query-perms" {
    name = "seefood-query-perms"
    policy = 
}

resource "aws_iam_role" "seefood-query-role" {
    name = "seefood-query-role"
    assume_role_policy = data.aws.aws_iam_policy_document.seefood-query-assume-role.json
}

resource "aws_lambda_function" "seefood-query" {
    filename = "dependencies.zip" 
    function_name = "seefood-query"
    runtime = "python3.12"    
    role = 
}