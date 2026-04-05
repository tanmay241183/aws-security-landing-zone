variable "security_account_id" {
  description = "Account ID of the delegated Security Audit account"
  type        = string
}

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
  description = "ARN of the central KMS key"
  type        = string
}

variable "cloudtrail_bucket_name" {
  description = "Name of the central CloudTrail S3 bucket"
  type        = string
}