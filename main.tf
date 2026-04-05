# AWS Security Landing Zone - Root main.tf
# Built manually step-by-step in VS Code

terraform {
  # Backend is configured in backend.tf
}

# Organization Module - Creates AWS Organization, OUs, and new accounts
module "organization" {
  source               = "./modules/organization"
  org_name             = var.org_name
  log_archive_email    = var.log_archive_email
  security_audit_email = var.security_audit_email
}

# KMS Module - Central Customer-Managed Key for encryption
module "kms" {
  source      = "./modules/kms"
  key_alias   = var.kms_key_alias
  region      = var.region
}

# Networking Module - Baseline secure VPC (Hub style)
module "networking" {
  source      = "./modules/networking"
  vpc_name    = "landing-zone-hub-vpc"
  cidr        = var.vpc_cidr
  region      = var.region
  kms_key_arn = module.kms.kms_key_arn
}

# IAM Module - Strong guardrails via SCPs
module "iam" {
  source          = "./modules/iam"
  organization_id = module.organization.organization_id   # Fixed reference
}

# Security Services Module
module "security" {
  source                 = "./modules/security"
  security_account_id    = module.organization.security_account_id
  log_archive_account_id = module.organization.log_archive_account_id
  region                 = var.region
  kms_key_arn            = module.kms.kms_key_arn
  cloudtrail_bucket_name = module.logging.cloudtrail_bucket_name   # ← New line
}

# Logging Module - Central S3 bucket for CloudTrail logs
module "logging" {
  source                 = "./modules/logging"
  log_archive_account_id = module.organization.log_archive_account_id
  region                 = var.region
  kms_key_arn            = module.kms.kms_key_arn     # ← Added
}

# Output important values for easy reference after apply
output "organization_id" {
  value = module.organization.organization_id
}

output "security_account_id" {
  value = module.organization.security_account_id
}

output "log_archive_account_id" {
  value = module.organization.log_archive_account_id
}

output "kms_key_arn" {
  value = module.kms.kms_key_arn
}

output "vpc_id" {
  value = module.networking.vpc_id
}