#============================================================================
# Authors: Thiago, Vitor, Rafael
# Description: Creates Lambda Infrastructure
#============================================================================

resource "aws_iam_role" "iam_role_7soat_lambda_execution" {
  name = var.lambda_role_name

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "lambda.amazonaws.com"
        }
      }
    ]
  })
}

resource "aws_iam_role_policy" "iam_role_policy_7soat_lambda_execution_custom" {
  name   = var.lambda_execution_policy_name
  role   = aws_iam_role.iam_role_7soat_lambda_execution.name

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "cognito-idp:*",
        ]
        Resource = ["*"]
      },
    ]
  })
}

resource "aws_iam_role_policy_attachment" "iam_role_policy_attachment_7soat_lambda_execution_AWSLambdaBasicExecutionRole" {
  role       = aws_iam_role.iam_role_7soat_lambda_execution.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}

data "aws_secretsmanager_secret" "secretsmanager_secret_7soat" {
  name = var.aws_secrets_name
}

data "aws_secretsmanager_secret_version" "secretsmanager_secret_7soat_version" {
  secret_id = data.aws_secretsmanager_secret.secretsmanager_secret_7soat.id
}

locals {
  secret_values = jsondecode(data.aws_secretsmanager_secret_version.secretsmanager_secret_7soat_version.secret_string)
}

resource "aws_lambda_function" "lambda_function_7soat" {
  function_name = var.lambda_function_name
  role          = aws_iam_role.iam_role_7soat_lambda_execution.arn
  handler       = var.lambda_function_handler
  runtime       = var.lambda_function_runtime
  filename      = var.lambda_function_filename

  environment {
    variables = {
      USER_POOL_ID = local.secret_values.USER_POOL_ID,
      CLIENT_ID = local.secret_values.CLIENT_ID
    }
  }

  memory_size = var.lambda_function_memory_size
  timeout     = var.lambda_function_timeout

  lifecycle {
    ignore_changes = [
      filename
    ]
  }
}

resource "aws_lambda_function_url" "lambda_function_7soat_url" {
  function_name = aws_lambda_function.lambda_function_7soat.function_name

  authorization_type = "NONE"

  cors {
    allow_origins = ["*"]
    allow_methods = ["*"]
  }
}

output "output_lambda_function_7soat_url" {
  value = aws_lambda_function_url.lambda_function_7soat_url.function_url
}