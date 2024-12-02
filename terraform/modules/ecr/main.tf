resource "aws_ecr_repository" "ecr_repository_tech_challenge_7soat_payments_service" {
  name = var.ecr_repository_payments_service_name
}

resource "aws_ecr_repository" "ecr_repository_tech_challenge_7soat_orders_service" {
  name = var.ecr_repository_orders_service_name
}

resource "aws_ecr_repository" "ecr_repository_tech_challenge_7soat_products_catalog_service" {
  name = var.ecr_repository_products_catalog_name
}
