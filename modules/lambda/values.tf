variable "aws_secrets_name" {
  type        = string
  description = "The name of the AWS Secrets Manager secret."
}

variable "lambda_role_name" {
  type        = string
  description = "The name of the Lambda execution role."
}

variable "lambda_execution_policy_name" {
  type        = string
  description = "The name of the Lambda execution policy."
}

variable "lambda_function_name" {
  type        = string
  description = "The name of the Lambda function."
}

variable "lambda_function_handler" {
  type        = string
  description = "The handler of the Lambda function."
}

variable "lambda_function_runtime" {
  type        = string
  description = "The runtime environment for the Lambda function."
}

variable "lambda_function_filename" {
  type        = string
  description = "The path to the Lambda function deployment package."
}

variable "lambda_function_memory_size" {
  type        = number
  description = "The memory size (in MB) allocated to the Lambda function."
}

variable "lambda_function_timeout" {
  type        = number
  description = "The timeout (in seconds) for the Lambda function."
}
