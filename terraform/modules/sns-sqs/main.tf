#============================================================================
# Authors: Thiago, Vitor, Rafael
# Description: Creates SNS and SQS infrastructure
#============================================================================

resource "aws_sqs_queue" "sqs_queue_7soat_orders_service_dlq" {
  name                          = var.orders_service_queue_dlq_name
  fifo_queue                    = true
  content_based_deduplication   = true
  delay_seconds                 = var.orders_service_queue_dlq_delay_seconds
  max_message_size              = var.orders_service_queue_dlq_max_message_size
  message_retention_seconds     = var.orders_service_queue_dlq_message_retention_seconds
  receive_wait_time_seconds     = var.orders_service_queue_dlq_receive_wait_time_seconds
  visibility_timeout_seconds    = var.orders_service_queue_dlq_visibility_timeout_seconds
  deduplication_scope           = var.orders_service_queue_dlq_deduplication_scope
  fifo_throughput_limit         = var.orders_service_queue_dlq_fifo_throughput_limit
}

resource "aws_sqs_queue" "sqs_queue_7soat_orders_service" {
  name                          = var.orders_service_queue_name
  fifo_queue                    = true
  content_based_deduplication   = true
  delay_seconds                 = var.orders_service_queue_delay_seconds
  max_message_size              = var.orders_service_queue_max_message_size
  message_retention_seconds     = var.orders_service_queue_message_retention_seconds
  receive_wait_time_seconds     = var.orders_service_queue_receive_wait_time_seconds
  visibility_timeout_seconds    = var.orders_service_queue_visibility_timeout_seconds
  deduplication_scope           = var.orders_service_queue_deduplication_scope
  fifo_throughput_limit         = var.orders_service_queue_fifo_throughput_limit
  
  redrive_policy = jsonencode({
    deadLetterTargetArn = aws_sqs_queue.sqs_queue_7soat_orders_service_dlq.arn
    maxReceiveCount     = var.orders_service_queue_redrive_policy_max_receive_count
  })
}

resource "aws_sqs_queue_policy" "sqs_queue_7soat_orders_service_policy" {
  queue_url = aws_sqs_queue.sqs_queue_7soat_orders_service.url
  policy    = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect    = "Allow"
        Action    = "SQS:SendMessage"
        Resource  = aws_sqs_queue.sqs_queue_7soat_orders_service.arn
        Principal = {
          Service = "sns.amazonaws.com"
        }
        Condition = {
          ArnEquals = {
            "aws:SourceArn" = aws_sns_topic.sns_topic_payments_service.arn
          }
        }
      }
    ]
  })
}

/* resource "aws_sqs_queue" "sqs_queue_7soat_payments_service_dlq" {
  name                          = var.payments_service_queue_dlq_name
  fifo_queue                    = true
  content_based_deduplication   = true
  delay_seconds                 = var.payments_service_queue_dlq_delay_seconds
  max_message_size              = var.payments_service_queue_dlq_max_message_size
  message_retention_seconds     = var.payments_service_queue_dlq_message_retention_seconds
  receive_wait_time_seconds     = var.payments_service_queue_dlq_receive_wait_time_seconds
  visibility_timeout_seconds    = var.payments_service_queue_dlq_visibility_timeout_seconds
  deduplication_scope           = var.payments_service_queue_dlq_deduplication_scope
  fifo_throughput_limit         = var.payments_service_queue_dlq_fifo_throughput_limit
} */

/* resource "aws_sqs_queue_policy" "sqs_queue_7soat_payments_service_dlq_policy" {
  queue_url = aws_sqs_queue.sqs_queue_7soat_payments_service_dlq.url
  policy    = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect    = "Allow"
        Action    = "SQS:SendMessage"
        Resource  = aws_sqs_queue.sqs_queue_7soat_payments_service_dlq.arn
        Principal = {
          Service = "sns.amazonaws.com"
        }
        Condition = {
          ArnEquals = {
            "aws:SourceArn" = aws_sns_topic.sns_topic_payments_service.arn
          }
        }
      }
    ]
  })
} */

resource "aws_sns_topic" "sns_topic_payments_service" {
  name                        = var.payments_service_topic_name
  fifo_topic                  = true
  content_based_deduplication = true

  tags = {
    Name = var.payments_service_topic_name
  }
}

resource "aws_sns_topic_policy" "sns_topic_policy_payments_service" {
  arn = aws_sns_topic.sns_topic_payments_service.arn

  policy = jsonencode({
    Version = "2008-10-17",
    Id      = "__default_policy_ID",
    Statement = [
      {
        Sid       = "__default_statement_ID",
        Effect    = "Allow",
        Principal = {
          AWS = "*"
        },
        Action = [
          "SNS:Publish",
          "SNS:RemovePermission",
          "SNS:SetTopicAttributes",
          "SNS:DeleteTopic",
          "SNS:ListSubscriptionsByTopic",
          "SNS:GetTopicAttributes",
          "SNS:AddPermission",
          "SNS:Subscribe"
        ],
        Resource = aws_sns_topic.sns_topic_payments_service.arn,
        Condition = {
          StringEquals = {
            "AWS:SourceOwner" = var.aws_account_id
          }
        }
      }
    ]
  })
}

resource "aws_sns_topic_subscription" "sns_topic_subscription_payments_service_queue" {
  topic_arn = aws_sns_topic.sns_topic_payments_service.arn
  protocol  = "sqs"
  endpoint  = resource.aws_sqs_queue.sqs_queue_7soat_orders_service.arn
  filter_policy_scope = "MessageBody"
  raw_message_delivery = true

  filter_policy = jsonencode({
    target = ["ORDERS_SERVICE"]
  })

/*   redrive_policy = jsonencode({
    deadLetterTargetArn = resource.aws_sqs_queue.sqs_queue_7soat_payments_service_dlq.arn
  }) */
}
