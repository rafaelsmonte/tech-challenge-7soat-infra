terraform {
  backend "s3" {
    bucket = "tech-challenge-7soat-infra-terraform-state"
    key    = "eks-cluster/terraform.tfstate"
    region = "us-east-1"
    profile = "default"
  }
  required_providers {
    helm = {
      source  = "hashicorp/helm"
      version = "~> 2.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}

provider "kubernetes" {
  config_path = "~/.kube/config"
}

provider "helm" {
  kubernetes {
    config_path = "~/.kube/config"
  }
}

resource "aws_ecr_repository" "ecr_repository_tech_challenge_7soat" {
  name = var.ecr_repository_name
}

module "kubernetes_infra" {
  source = "./modules/kubernetes-infra"
  eks_cluster_name = var.eks_cluster_name
  eks_cluster_role_arn = var.eks_cluster_role_arn
  eks_subnet_ids = var.eks_subnet_ids
  eks_security_group_ids = var.eks_security_group_ids
  eks_node_group_name = var.eks_node_group_name
  eks_node_group_role = var.eks_node_group_role
  eks_node_group_subnets = var.eks_node_group_subnets
  eks_node_group_scaling_config = var.eks_node_group_scaling_config
  eks_node_group_instance_types = var.eks_node_group_instance_types
  eks_node_group_ami_type = var.eks_node_group_ami_type
  eks_node_group_capacity_type = var.eks_node_group_capacity_type
  eks_node_group_disk_size = var.eks_node_group_disk_size
  eks_node_group_access_key = var.eks_node_group_access_key
  
  depends_on = [resource.aws_ecr_repository.ecr_repository_tech_challenge_7soat]
}

module "kubernetes_drivers" {
  source = "./modules/kubernetes-drivers"
  depends_on = [module.kubernetes_infra]
}

module "lambda" {
  source = "./modules/lambda"

  aws_secrets_name                    = var.aws_secrets_name
  lambda_role_name                    = var.lambda_role_name
  lambda_execution_policy_name        = var.lambda_execution_policy_name
  lambda_function_name                = var.lambda_function_name
  lambda_function_handler             = var.lambda_function_handler
  lambda_function_runtime             = var.lambda_function_runtime
  lambda_function_filename            = var.lambda_function_filename
  lambda_function_memory_size         = var.lambda_function_memory_size
  lambda_function_timeout             = var.lambda_function_timeout
}


module "cognito" {
  source = "./modules/cognito"

  cognito_database_name                                      = var.cognito_database_name
  cognito_database_password_policy_minimum_length            = var.cognito_database_password_policy_minimum_length
  cognito_database_password_policy_require_uppercase         = var.cognito_database_password_policy_require_uppercase
  cognito_database_password_policy_require_lowercase         = var.cognito_database_password_policy_require_lowercase
  cognito_database_password_policy_require_numbers           = var.cognito_database_password_policy_require_numbers
  cognito_database_password_policy_require_symbols           = var.cognito_database_password_policy_require_symbols
  cognito_database_password_policy_temporary_password_validity_days = var.cognito_database_password_policy_temporary_password_validity_days
  cognito_database_auto_verified_attributes                  = var.cognito_database_auto_verified_attributes
  cognito_database_account_recovery_setting_recovery_mechanism_name = var.cognito_database_account_recovery_setting_recovery_mechanism_name
  cognito_database_account_recovery_setting_recovery_mechanism_priority = var.cognito_database_account_recovery_setting_recovery_mechanism_priority
  cognito_database_admin_create_user_config_allow_admin_create_user_only = var.cognito_database_admin_create_user_config_allow_admin_create_user_only
  cognito_database_email_configuration_email_sending_account = var.cognito_database_email_configuration_email_sending_account
  cognito_database_user_pool_name                            = var.cognito_database_user_pool_name
  cognito_database_user_pool_generate_secret                 = var.cognito_database_user_pool_generate_secret
  cognito_database_user_pool_explicit_auth_flows             = var.cognito_database_user_pool_explicit_auth_flows
  cognito_database_user_pool_refresh_token_validity          = var.cognito_database_user_pool_refresh_token_validity
}

module "api-gateway" {
  source = "./modules/api-gateway"

  api_gateway_name                              = var.api_gateway_name
  api_gateway_protocol_type                     = var.api_gateway_protocol_type
  api_gateway_lambda_permission_statement_id    = var.api_gateway_lambda_permission_statement_id
  api_gateway_lambda_permission_action           = var.api_gateway_lambda_permission_action
  api_gateway_lambda_permission_function_name    = var.api_gateway_lambda_permission_function_name
  api_gateway_lambda_permission_principal       = var.api_gateway_lambda_permission_principal
  api_gateway_lambda_integration_integration_type = var.api_gateway_lambda_integration_integration_type
  api_gateway_lambda_integration_integration_uri = var.api_gateway_lambda_integration_integration_uri
  api_gateway_lambda_integration_payload_format_version = var.api_gateway_lambda_integration_payload_format_version
  api_gateway_eks_integration_integration_type  = var.api_gateway_eks_integration_integration_type
  api_gateway_eks_integration_integration_method = var.api_gateway_eks_integration_integration_method
  api_gateway_eks_integration_connection_type    = var.api_gateway_eks_integration_connection_type
  api_gateway_eks_integration_integration_uri    = var.api_gateway_eks_integration_integration_uri
  api_gateway_auto_deploy                       = var.api_gateway_auto_deploy
}
