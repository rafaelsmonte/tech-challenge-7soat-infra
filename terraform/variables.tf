variable "aws_vpc_id" {
  description = "The AWS VPC ID"
  type        = string
}

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

variable "api_gateway_products_catalog_service_integration_type" {
  description = "The integration type for EKS integration (HTTP_PROXY)"
  type        = string
}

variable "api_gateway_products_catalog_service_integration_method" {
  description = "The HTTP method for the EKS integration"
  type        = string
}

variable "api_gateway_products_catalog_service_connection_type" {
  description = "The connection type for EKS integration (INTERNET)"
  type        = string
}

variable "api_gateway_products_catalog_service_integration_uri" {
  description = "The URI of the EKS integration for API Gateway"
  type        = string
}

variable "api_gateway_auto_deploy" {
  description = "Whether to enable auto-deploy for the API Gateway"
  type        = bool
}

variable "orders_service_queue_dlq_name" {
  description = "Name of the dead-letter queue for the orders service."
  type        = string
}

variable "orders_service_queue_dlq_delay_seconds" {
  description = "Delay seconds for the dead-letter queue of the orders service."
  type        = number
}

variable "orders_service_queue_dlq_max_message_size" {
  description = "Maximum message size (in bytes) for the dead-letter queue of the orders service."
  type        = number
}

variable "orders_service_queue_dlq_message_retention_seconds" {
  description = "Message retention period (in seconds) for the dead-letter queue of the orders service."
  type        = number
}

variable "orders_service_queue_dlq_receive_wait_time_seconds" {
  description = "Receive wait time (in seconds) for the dead-letter queue of the orders service."
  type        = number
}

variable "orders_service_queue_dlq_visibility_timeout_seconds" {
  description = "Visibility timeout (in seconds) for the dead-letter queue of the orders service."
  type        = number
}

variable "orders_service_queue_dlq_deduplication_scope" {
  description = "Deduplication scope for the dead-letter queue of the orders service."
  type        = string
}

variable "orders_service_queue_dlq_fifo_throughput_limit" {
  description = "FIFO throughput limit for the dead-letter queue of the orders service."
  type        = string
}

variable "orders_service_queue_name" {
  description = "Name of the main SQS queue for the orders service."
  type        = string
}

variable "orders_service_queue_delay_seconds" {
  description = "Delay seconds for the main SQS queue of the orders service."
  type        = number
}

variable "orders_service_queue_max_message_size" {
  description = "Maximum message size (in bytes) for the main SQS queue of the orders service."
  type        = number
}

variable "orders_service_queue_message_retention_seconds" {
  description = "Message retention period (in seconds) for the main SQS queue of the orders service."
  type        = number
}

variable "orders_service_queue_receive_wait_time_seconds" {
  description = "Receive wait time (in seconds) for the main SQS queue of the orders service."
  type        = number
}

variable "orders_service_queue_visibility_timeout_seconds" {
  description = "Visibility timeout (in seconds) for the main SQS queue of the orders service."
  type        = number
}

variable "orders_service_queue_deduplication_scope" {
  description = "Deduplication scope for the main SQS queue of the orders service."
  type        = string
}

variable "orders_service_queue_fifo_throughput_limit" {
  description = "FIFO throughput limit for the main SQS queue of the orders service."
  type        = string
}

variable "orders_service_queue_redrive_policy_max_receive_count" {
  description = "Maximum receive count for the redrive policy of the orders service queue."
  type        = number
}

variable "payments_service_queue_dlq_name" {
  description = "Name of the dead-letter queue for the payments service."
  type        = string
}

variable "payments_service_queue_dlq_delay_seconds" {
  description = "Delay seconds for the dead-letter queue of the payments service."
  type        = number
}

variable "payments_service_queue_dlq_max_message_size" {
  description = "Maximum message size (in bytes) for the dead-letter queue of the payments service."
  type        = number
}

variable "payments_service_queue_dlq_message_retention_seconds" {
  description = "Message retention period (in seconds) for the dead-letter queue of the payments service."
  type        = number
}

variable "payments_service_queue_dlq_receive_wait_time_seconds" {
  description = "Receive wait time (in seconds) for the dead-letter queue of the payments service."
  type        = number
}

variable "payments_service_queue_dlq_visibility_timeout_seconds" {
  description = "Visibility timeout (in seconds) for the dead-letter queue of the payments service."
  type        = number
}

variable "payments_service_queue_dlq_deduplication_scope" {
  description = "Deduplication scope for the dead-letter queue of the payments service."
  type        = string
}

variable "payments_service_queue_dlq_fifo_throughput_limit" {
  description = "FIFO throughput limit for the dead-letter queue of the payments service."
  type        = string
}

variable "payments_service_topic_name" {
  description = "Name of the SNS topic for the payments service."
  type        = string
}

variable "aws_account_id" {
  description = "AWS account ID for topic access policies."
  type        = string
}

variable "ecr_repository_payments_service_name" {
  description = "Name of the payments service ecr repository"
  type        = string
}

variable "ecr_repository_orders_service_name" {
  description = "Name of the orders service ecr repository"
  type        = string
}

variable "ecr_repository_products_catalog_name" {
  description = "Name of the products service ecr repository"
  type        = string
}

variable "eks_cluster_security_group_name" {
  description = "The name of the EKS cluster security group"
  type        = string
}

variable "eks_cluster_security_group_description" {
  description = "The description of the EKS cluster security group"
  type        = string
}

variable "api_gateway_orders_service_integration_type" {
  description = "The type of integration for the orders service (e.g., HTTP_PROXY, AWS_PROXY)"
  type        = string
}

variable "api_gateway_orders_service_integration_method" {
  description = "The HTTP method used for the orders service integration (e.g., GET, POST, ANY)"
  type        = string
}

variable "api_gateway_orders_service_connection_type" {
  description = "The type of connection for the orders service integration (e.g., INTERNET, VPC_LINK)"
  type        = string
}

variable "api_gateway_orders_service_integration_uri" {
  description = "The URI for the orders service integration"
  type        = string
}

variable "api_gateway_payments_service_integration_type" {
  description = "The type of integration for the payments service (e.g., HTTP_PROXY, AWS_PROXY)"
  type        = string
}

variable "api_gateway_payments_service_integration_method" {
  description = "The HTTP method used for the payments service integration (e.g., GET, POST, ANY)"
  type        = string
}

variable "api_gateway_payments_service_connection_type" {
  description = "The type of connection for the payments service integration (e.g., INTERNET, VPC_LINK)"
  type        = string
}

variable "api_gateway_payments_service_integration_uri" {
  description = "The URI for the payments service integration"
  type        = string
}