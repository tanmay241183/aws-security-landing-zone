variable "key_alias" {
  description = "Alias name for the central KMS key"
  type        = string
  default     = "landing-zone-central-key"
}

variable "description" {
  description = "Description for the KMS key"
  type        = string
  default     = "Central KMS customer-managed key for Landing Zone encryption"
}

variable "region" {
  description = "AWS region for the KMS key"
  type        = string
  default     = "ap-southeast-2"
}

variable "enable_key_rotation" {
  description = "Enable automatic key rotation"
  type        = bool
  default     = true
}