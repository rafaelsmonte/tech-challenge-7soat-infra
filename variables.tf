variable "eks_cluster_name" {
  description = "Name of the EKS cluster"
  type        = string
}

variable "eks_cluster_role_arn" {
  description = "ARN of the IAM role to associate with the EKS cluster"
  type        = string
}

variable "eks_subnet_ids" {
  description = "Comma-separated list of subnet IDs where EKS should deploy worker nodes"
  type        = list(string)
}

variable "eks_security_group_ids" {
  description = "Security group IDs for the EKS cluster"
  type        = list(string)
}

variable "ecr_repository_name" {
  description = "The name of the ECR repository to place images of 7soat api's"
  type        = string
}

variable "eks_node_group_name" {
  description = "The name of the EKS node group."
  type        = string
}

variable "eks_node_group_role" {
  description = "The IAM role ARN used for the EKS node group."
  type        = string
}

variable "eks_node_group_subnets" {
  description = "The subnets for the EKS node group."
  type        = list(string)
}

variable "eks_node_group_scaling_config" {
  description = "The scaling configuration for the EKS node group."
  type = object({
    desired_size = number
    max_size     = number
    min_size     = number
  })
}

variable "eks_node_group_ami_type" {
  description = "The AMI type for the EKS node group."
  type        = string
}

variable "eks_node_group_instance_types" {
  description = "The instance types for the EKS node group."
  type        = list(string)
}

variable "eks_node_group_capacity_type" {
  description = "The capacity type for the EKS node group."
  type        = string
}

variable "eks_node_group_disk_size" {
  description = "The disk size (in GiB) for the EKS node group instances."
  type        = number
}

variable "eks_node_group_access_key" {
  description = "The SSH key pair for remote access to the EKS node group instances."
  type        = string
}

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

variable "cognito_database_name" {
  type        = string
  description = "The name of the Cognito database."
}

variable "cognito_database_password_policy_minimum_length" {
  type        = number
  description = "The minimum length for passwords in the Cognito database."
}

variable "cognito_database_password_policy_require_uppercase" {
  type        = bool
  description = "Whether to require uppercase letters in passwords."
}

variable "cognito_database_password_policy_require_lowercase" {
  type        = bool
  description = "Whether to require lowercase letters in passwords."
}

variable "cognito_database_password_policy_require_numbers" {
  type        = bool
  description = "Whether to require numbers in passwords."
}

variable "cognito_database_password_policy_require_symbols" {
  type        = bool
  description = "Whether to require symbols in passwords."
}

variable "cognito_database_password_policy_temporary_password_validity_days" {
  type        = number
  description = "The number of days temporary passwords are valid."
}

variable "cognito_database_auto_verified_attributes" {
  type        = list(string)
  description = "The attributes that Cognito automatically verifies."
}

variable "cognito_database_account_recovery_setting_recovery_mechanism_name" {
  type        = string
  description = "The recovery mechanism name for account recovery."
}

variable "cognito_database_account_recovery_setting_recovery_mechanism_priority" {
  type        = number
  description = "The priority of the account recovery mechanism."
}

variable "cognito_database_admin_create_user_config_allow_admin_create_user_only" {
  type        = bool
  description = "Whether to allow only administrators to create users."
}

variable "cognito_database_email_configuration_email_sending_account" {
  type        = string
  description = "The email sending account configuration."
}

variable "cognito_database_user_pool_name" {
  type        = string
  description = "The name of the Cognito user pool."
}

variable "cognito_database_user_pool_generate_secret" {
  type        = bool
  description = "Whether to generate a client secret for the user pool."
}

variable "cognito_database_user_pool_explicit_auth_flows" {
  type        = list(string)
  description = "The explicit authentication flows allowed for the user pool."
}

variable "cognito_database_user_pool_refresh_token_validity" {
  type        = number
  description = "The number of days the refresh token is valid."
}

variable "api_gateway_name" {
  description = "The name of the API Gateway"
  type        = string
}

variable "api_gateway_protocol_type" {
  description = "The protocol type for the API Gateway (HTTP, WEBSOCKET)"
  type        = string
}

variable "api_gateway_lambda_permission_statement_id" {
  description = "The statement ID for the Lambda permission associated with the API Gateway"
  type        = string
}

variable "api_gateway_lambda_permission_action" {
  description = "The Lambda permission action for the API Gateway"
  type        = string
}

variable "api_gateway_lambda_permission_function_name" {
  description = "The Lambda function name for the API Gateway permission"
  type        = string
}

variable "api_gateway_lambda_permission_principal" {
  description = "The principal used for the Lambda permission"
  type        = string
}

variable "api_gateway_lambda_integration_integration_type" {
  description = "The integration type for Lambda integration (AWS_PROXY)"
  type        = string
}

variable "api_gateway_lambda_integration_integration_uri" {
  description = "The URI of the Lambda function to integrate with API Gateway"
  type        = string
}

variable "api_gateway_lambda_integration_payload_format_version" {
  description = "The payload format version for Lambda integration"
  type        = string
}

variable "api_gateway_eks_integration_integration_type" {
  description = "The integration type for EKS integration (HTTP_PROXY)"
  type        = string
}

variable "api_gateway_eks_integration_integration_method" {
  description = "The HTTP method for the EKS integration"
  type        = string
}

variable "api_gateway_eks_integration_connection_type" {
  description = "The connection type for EKS integration (INTERNET)"
  type        = string
}

variable "api_gateway_eks_integration_integration_uri" {
  description = "The URI of the EKS integration for API Gateway"
  type        = string
}

variable "api_gateway_auto_deploy" {
  description = "Whether to enable auto-deploy for the API Gateway"
  type        = bool
}
