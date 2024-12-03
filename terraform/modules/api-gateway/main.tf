#============================================================================
# Authors: Thiago, Vitor, Rafael
# Description: Creates API Gateway
#============================================================================
resource "aws_apigatewayv2_api" "apigatewayv2_api_gateway_7soat" {
  name          = var.api_gateway_name
  protocol_type = var.api_gateway_protocol_type
  disable_execute_api_endpoint = false

  # Enable path normalization
  cors_configuration {
    allow_headers = ["*"]
    allow_methods = ["*"]
    allow_origins = ["*"]
    expose_headers = ["*"]
    max_age = 300
  }
}

#===========================================================
# Api gateway configuration for /customer at lambda function
#===========================================================
resource "aws_lambda_permission" "lambda_permission_allow_api_gateway" {
  statement_id  = var.api_gateway_lambda_permission_statement_id
  action        = var.api_gateway_lambda_permission_action
  function_name = var.api_gateway_lambda_permission_function_name
  principal     = var.api_gateway_lambda_permission_principal
  source_arn    = "${aws_apigatewayv2_api.apigatewayv2_api_gateway_7soat.execution_arn}/*/*"
}

resource "aws_apigatewayv2_integration" "apigatewayv2_integration_lambda_integration" {
  api_id = aws_apigatewayv2_api.apigatewayv2_api_gateway_7soat.id
  integration_type = var.api_gateway_lambda_integration_integration_type
  integration_uri = var.api_gateway_lambda_integration_integration_uri
  payload_format_version = var.api_gateway_lambda_integration_payload_format_version

  # Grant API Gateway permission to invoke your Lambda function
  depends_on = [aws_lambda_permission.lambda_permission_allow_api_gateway]
}

resource "aws_apigatewayv2_route" "customer_route" {
  api_id     = aws_apigatewayv2_api.apigatewayv2_api_gateway_7soat.id
  route_key  = "ANY /apis/auth/customer/{proxy+}"
  target     = "integrations/${aws_apigatewayv2_integration.apigatewayv2_integration_lambda_integration.id}"
}

#============================================================
# Api gateway configuration for products catalog service apis
#============================================================
resource "aws_apigatewayv2_integration" "apigatewayv2_integration_products_catalog_service_integration" {
  api_id            = aws_apigatewayv2_api.apigatewayv2_api_gateway_7soat.id
  integration_type  = var.api_gateway_products_catalog_service_integration_type
  integration_method = var.api_gateway_products_catalog_service_integration_method
  connection_type   = var.api_gateway_products_catalog_service_connection_type
  integration_uri   = var.api_gateway_products_catalog_service_integration_uri
}

resource "aws_apigatewayv2_route" "proxy_route_products_apis" {
  api_id     = aws_apigatewayv2_api.apigatewayv2_api_gateway_7soat.id
  route_key  = "ANY /apis/products-catalog/{proxy+}"
  target     = "integrations/${aws_apigatewayv2_integration.apigatewayv2_integration_products_catalog_service_integration.id}"
}

#============================================================
# Api gateway configuration for orders service apis
#============================================================
resource "aws_apigatewayv2_integration" "apigatewayv2_integration_orders_service_integration" {
  api_id            = aws_apigatewayv2_api.apigatewayv2_api_gateway_7soat.id
  integration_type  = var.api_gateway_orders_service_integration_type
  integration_method = var.api_gateway_orders_service_integration_method
  connection_type   = var.api_gateway_orders_service_connection_type
  integration_uri   = var.api_gateway_orders_service_integration_uri
}

resource "aws_apigatewayv2_route" "proxy_route_orders_apis" {
  api_id     = aws_apigatewayv2_api.apigatewayv2_api_gateway_7soat.id
  route_key  = "ANY /apis/orders/{proxy+}"
  target     = "integrations/${aws_apigatewayv2_integration.apigatewayv2_integration_orders_service_integration.id}"
}

#============================================================
# Api gateway configuration for payments service apis
#============================================================
resource "aws_apigatewayv2_integration" "apigatewayv2_integration_payments_service_integration" {
  api_id            = aws_apigatewayv2_api.apigatewayv2_api_gateway_7soat.id
  integration_type  = var.api_gateway_payments_service_integration_type
  integration_method = var.api_gateway_payments_service_integration_method
  connection_type   = var.api_gateway_payments_service_connection_type
  integration_uri   = var.api_gateway_payments_service_integration_uri
}

resource "aws_apigatewayv2_route" "proxy_route_payments_apis" {
  api_id     = aws_apigatewayv2_api.apigatewayv2_api_gateway_7soat.id
  route_key  = "ANY /apis/payments/{proxy+}"
  target     = "integrations/${aws_apigatewayv2_integration.apigatewayv2_integration_payments_service_integration.id}"
}

#============================================================
# Api gateway configuration for prod stage
#============================================================
resource "aws_apigatewayv2_stage" "prod" {
  api_id    = aws_apigatewayv2_api.apigatewayv2_api_gateway_7soat.id
  name      = "$default"
  auto_deploy = var.api_gateway_auto_deploy
}
