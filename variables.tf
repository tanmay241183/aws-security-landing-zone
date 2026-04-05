variable "org_name" {
  description = "Name of the AWS Organization"
  type        = string
  default     = "MySecureOrg"
}

variable "log_archive_email" {
  description = "Unique email address for the Log Archive account (use +tag if Gmail)"
  type        = string
}

variable "security_audit_email" {
  description = "Unique email address for the Security Audit account (use +tag if Gmail)"
  type        = string
}

variable "region" {
  description = "Primary AWS region"
  type        = string
  default     = "ap-southeast-2"
}

variable "vpc_cidr" {
  description = "CIDR block for the baseline VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "kms_key_alias" {
  description = "Alias for the central KMS key"
  type        = string
  default     = "landing-zone-central-key"
}