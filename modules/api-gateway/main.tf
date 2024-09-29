#============================================================================
# Authors: Thiago, Vitor, Rafael
# Description: Creates API Gateway
#============================================================================
resource "aws_apigatewayv2_api" "apigatewayv2_api_gateway_7soat" {
  name          = var.api_gateway_name
  protocol_type = var.api_gateway_protocol_type
}

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

resource "aws_apigatewayv2_integration" "apigatewayv2_integration_eks_integration" {
  api_id            = aws_apigatewayv2_api.apigatewayv2_api_gateway_7soat.id
  integration_type  = var.api_gateway_eks_integration_integration_type
  integration_method = var.api_gateway_eks_integration_integration_method
  connection_type   = var.api_gateway_eks_integration_connection_type
  integration_uri   = var.api_gateway_eks_integration_integration_uri
}

resource "aws_apigatewayv2_route" "customer_route" {
  api_id     = aws_apigatewayv2_api.apigatewayv2_api_gateway_7soat.id
  route_key  = "ANY /customer/{proxy+}"
  target     = "integrations/${aws_apigatewayv2_integration.apigatewayv2_integration_lambda_integration.id}"
}

resource "aws_apigatewayv2_route" "proxy_route" {
  api_id     = aws_apigatewayv2_api.apigatewayv2_api_gateway_7soat.id
  route_key  = "$default"
  target     = "integrations/${aws_apigatewayv2_integration.apigatewayv2_integration_eks_integration.id}"
}

resource "aws_apigatewayv2_stage" "prod" {
  api_id    = aws_apigatewayv2_api.apigatewayv2_api_gateway_7soat.id
  name      = "$default"
  auto_deploy = var.api_gateway_auto_deploy
}
