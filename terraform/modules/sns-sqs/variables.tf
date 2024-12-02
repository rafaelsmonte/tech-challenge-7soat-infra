variable "orders_service_queue_dlq_name" {
  description = "The name of the orders service dead-letter queue."
  type        = string
}

variable "orders_service_queue_dlq_delay_seconds" {
  description = "The delay seconds for the orders service dead-letter queue."
  type        = number
}

variable "orders_service_queue_dlq_max_message_size" {
  description = "The maximum message size for the orders service dead-letter queue."
  type        = number
}

variable "orders_service_queue_dlq_message_retention_seconds" {
  description = "The message retention seconds for the orders service dead-letter queue."
  type        = number
}

variable "orders_service_queue_dlq_receive_wait_time_seconds" {
  description = "The receive wait time seconds for the orders service dead-letter queue."
  type        = number
}

variable "orders_service_queue_dlq_visibility_timeout_seconds" {
  description = "The visibility timeout seconds for the orders service dead-letter queue."
  type        = number
}

variable "orders_service_queue_dlq_deduplication_scope" {
  description = "The deduplication scope for the orders service dead-letter queue."
  type        = string
}

variable "orders_service_queue_dlq_fifo_throughput_limit" {
  description = "The FIFO throughput limit for the orders service dead-letter queue."
  type        = string
}

variable "orders_service_queue_name" {
  description = "The name of the orders service queue."
  type        = string
}

variable "orders_service_queue_delay_seconds" {
  description = "The delay seconds for the orders service queue."
  type        = number
}

variable "orders_service_queue_max_message_size" {
  description = "The maximum message size for the orders service queue."
  type        = number
}

variable "orders_service_queue_message_retention_seconds" {
  description = "The message retention seconds for the orders service queue."
  type        = number
}

variable "orders_service_queue_receive_wait_time_seconds" {
  description = "The receive wait time seconds for the orders service queue."
  type        = number
}

variable "orders_service_queue_visibility_timeout_seconds" {
  description = "The visibility timeout seconds for the orders service queue."
  type        = number
}

variable "orders_service_queue_deduplication_scope" {
  description = "The deduplication scope for the orders service queue."
  type        = string
}

variable "orders_service_queue_fifo_throughput_limit" {
  description = "The FIFO throughput limit for the orders service queue."
  type        = string
}

variable "orders_service_queue_redrive_policy_max_receive_count" {
  description = "The maximum receive count for the orders service queue redrive policy."
  type        = number
}

variable "payments_service_queue_dlq_name" {
  description = "The name of the payments service dead-letter queue."
  type        = string
}

variable "payments_service_queue_dlq_delay_seconds" {
  description = "The delay seconds for the payments service dead-letter queue."
  type        = number
}

variable "payments_service_queue_dlq_max_message_size" {
  description = "The maximum message size for the payments service dead-letter queue."
  type        = number
}

variable "payments_service_queue_dlq_message_retention_seconds" {
  description = "The message retention seconds for the payments service dead-letter queue."
  type        = number
}

variable "payments_service_queue_dlq_receive_wait_time_seconds" {
  description = "The receive wait time seconds for the payments service dead-letter queue."
  type        = number
}

variable "payments_service_queue_dlq_visibility_timeout_seconds" {
  description = "The visibility timeout seconds for the payments service dead-letter queue."
  type        = number
}

variable "payments_service_queue_dlq_deduplication_scope" {
  description = "The deduplication scope for the payments service dead-letter queue."
  type        = string
}

variable "payments_service_queue_dlq_fifo_throughput_limit" {
  description = "The FIFO throughput limit for the payments service dead-letter queue."
  type        = string
}

variable "payments_service_topic_name" {
  description = "The name of the payments service topic."
  type        = string
}

variable "aws_account_id" {
  description = "The AWS account ID for permissions configuration."
  type        = string
}
