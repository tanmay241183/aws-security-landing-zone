variable "org_name" {
  description = "Name of the AWS Organization"
  type        = string
  default     = "MySecureOrg"
}

variable "log_archive_email" {
  description = "Unique email address for the Log Archive account"
  type        = string
}

variable "security_audit_email" {
  description = "Unique email address for the Security Audit account"
  type        = string
}