variable "log_archive_account_id" {
  description = "Account ID of the Log Archive account"
  type        = string
}

variable "region" {
  description = "AWS region"
  type        = string
  default     = "ap-southeast-2"
}

variable "kms_key_arn" {
  description = "ARN of the central KMS key for bucket encryption"
  type        = string
}