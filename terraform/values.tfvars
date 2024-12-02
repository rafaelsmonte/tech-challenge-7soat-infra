aws_vpc_id = "vpc-935824e9"
aws_account_id = "839260668425"

ecr_repository_payments_service_name = "tech-challenge-7soat/payments-service"
ecr_repository_orders_service_name = "tech-challenge-7soat/orders-service"
ecr_repository_products_catalog_name = "tech-challenge-7soat/products-catalog-service"

eks_cluster_security_group_name = "tech-challenge-7soat-eks-cluster-sg"
eks_cluster_security_group_description = "Security group for 7 soat tech challenge eks cluster"

eks_cluster_name         = "tech-challenge-7soat"
eks_cluster_role_arn     = "arn:aws:iam::839260668425:role/AWS_EKS_ROLE"
eks_subnet_ids           = ["subnet-0d501603dbb6981a0","subnet-0628055b427ab2fe6"]
eks_node_group_name         = "tech-challenge-7soat-node-group"
eks_node_group_role         = "arn:aws:iam::839260668425:role/AWS_EKS_NODE_GROUP_ROLE"
eks_node_group_subnets      = ["subnet-0d501603dbb6981a0", "subnet-0628055b427ab2fe6"]
eks_node_group_scaling_config = {
  desired_size = 2
  max_size     = 4
  min_size     = 2
}
eks_node_group_ami_type     = "AL2_x86_64"
eks_node_group_instance_types = ["t3.medium"]
eks_node_group_capacity_type = "SPOT"
eks_node_group_disk_size    = 20
eks_node_group_access_key   = "tech-challenge-7soat-key"

aws_secrets_name = "7Soat"
lambda_role_name = "lambda-exec-7soat-role"
lambda_execution_policy_name = "tech_challenge_7soat_lambda_execution_policy"
lambda_function_name = "tech-challenge-7soat-authenticator"
lambda_function_handler = "index.handler"
lambda_function_runtime = "nodejs20.x"
lambda_function_filename = "/home/thiago/Documents/studies/tech-challenge-7soat-lambda/function_dir/function.zip"
lambda_function_memory_size = 128
lambda_function_timeout = 15

cognito_database_name = "tech-challenge-user-pool"
cognito_database_password_policy_minimum_length = 6
cognito_database_password_policy_require_uppercase = false
cognito_database_password_policy_require_lowercase = false
cognito_database_password_policy_require_numbers = false
cognito_database_password_policy_require_symbols =false
cognito_database_password_policy_temporary_password_validity_days = 7
cognito_database_auto_verified_attributes = []
cognito_database_account_recovery_setting_recovery_mechanism_name = "verified_email"
cognito_database_account_recovery_setting_recovery_mechanism_priority = 1
cognito_database_admin_create_user_config_allow_admin_create_user_only = false
cognito_database_email_configuration_email_sending_account = "COGNITO_DEFAULT"
cognito_database_user_pool_name = "tech-challenge-7soat-app"
cognito_database_user_pool_generate_secret = false
cognito_database_user_pool_explicit_auth_flows = ["ALLOW_USER_SRP_AUTH","ALLOW_REFRESH_TOKEN_AUTH","ALLOW_USER_PASSWORD_AUTH"]
cognito_database_user_pool_refresh_token_validity = 30

api_gateway_name = "tech-challenge-7soat-api-gateway"
api_gateway_protocol_type = "HTTP"
api_gateway_lambda_permission_statement_id = "AllowExecutionFromAPIGateway"
api_gateway_lambda_permission_action = "lambda:InvokeFunction"
api_gateway_lambda_permission_function_name = "tech-challenge-7soat-authenticator"
api_gateway_lambda_permission_principal = "apigateway.amazonaws.com"
api_gateway_lambda_integration_integration_type = "AWS_PROXY"
api_gateway_lambda_integration_integration_uri = "arn:aws:lambda:us-east-1:839260668425:function:tech-challenge-7soat-authenticator"
api_gateway_lambda_integration_payload_format_version = "2.0"
api_gateway_products_catalog_service_integration_type = "HTTP_PROXY"
api_gateway_products_catalog_service_integration_method = "ANY"
api_gateway_products_catalog_service_connection_type = "INTERNET"
api_gateway_products_catalog_service_integration_uri = "http://aae4e5db608bd4b9582f8a232d80dc9a-185296862.us-east-1.elb.amazonaws.com/{proxy}"
api_gateway_orders_service_integration_type             = "HTTP_PROXY"
api_gateway_orders_service_integration_method           = "ANY"
api_gateway_orders_service_connection_type              = "INTERNET"
api_gateway_orders_service_integration_uri              = "http://ab99b6af9136a48e3a444c8da2233b27-1912980319.us-east-1.elb.amazonaws.com/{proxy}"
api_gateway_payments_service_integration_type             = "HTTP_PROXY"
api_gateway_payments_service_integration_method           = "ANY"
api_gateway_payments_service_connection_type              = "INTERNET"
api_gateway_payments_service_integration_uri              = "http://a86e8eed4ae4c475ca4ad61781856a68-1785376984.us-east-1.elb.amazonaws.com/{proxy}"

api_gateway_auto_deploy = true

orders_service_queue_name                              = "tech-challenge-7soat-orders-service-queue.fifo"
orders_service_queue_delay_seconds                     = 0
orders_service_queue_max_message_size                  = 262144
orders_service_queue_message_retention_seconds         = 86400
orders_service_queue_receive_wait_time_seconds         = 0
orders_service_queue_visibility_timeout_seconds        = 300
orders_service_queue_deduplication_scope               = "messageGroup"
orders_service_queue_fifo_throughput_limit             = "perMessageGroupId"
orders_service_queue_redrive_policy_max_receive_count  = 5

orders_service_queue_dlq_name                              = "tech-challenge-7soat-orders-service-dlq.fifo"
orders_service_queue_dlq_delay_seconds                     = 0
orders_service_queue_dlq_max_message_size                  = 262144
orders_service_queue_dlq_message_retention_seconds         = 604800
orders_service_queue_dlq_receive_wait_time_seconds         = 0
orders_service_queue_dlq_visibility_timeout_seconds        = 60
orders_service_queue_dlq_deduplication_scope               = "messageGroup"
orders_service_queue_dlq_fifo_throughput_limit             = "perMessageGroupId"

payments_service_queue_dlq_name                              = "tech-challenge-7soat-payments-service-dlq.fifo"
payments_service_queue_dlq_delay_seconds                     = 0
payments_service_queue_dlq_max_message_size                  = 262144
payments_service_queue_dlq_message_retention_seconds         = 604800
payments_service_queue_dlq_receive_wait_time_seconds         = 0
payments_service_queue_dlq_visibility_timeout_seconds        = 60
payments_service_queue_dlq_deduplication_scope               = "messageGroup"
payments_service_queue_dlq_fifo_throughput_limit             = "perMessageGroupId"

payments_service_topic_name = "tech-challenge-7soat-payments-service-topic.fifo"