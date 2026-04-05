variable "vpc_name" {
  description = "Name of the baseline VPC"
  type        = string
  default     = "landing-zone-hub-vpc"
}

variable "cidr" {
  description = "CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "region" {
  description = "AWS region"
  type        = string
  default     = "ap-southeast-2"
}

variable "kms_key_arn" {
  description = "ARN of the KMS key to encrypt VPC Flow Logs"
  type        = string
}