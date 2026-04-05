# modules/security/main.tf
# Organization-wide security services: CloudTrail, GuardDuty, Security Hub
# Delegated to the Security-Audit account

# Organization CloudTrail with central logging bucket
resource "aws_cloudtrail" "org_trail" {
  name                          = "org-security-trail"
  is_multi_region_trail         = true
  include_global_service_events = true
  enable_logging                = true
  is_organization_trail         = true

  s3_bucket_name                = var.cloudtrail_bucket_name

  kms_key_id                    = var.kms_key_arn

  event_selector {
    read_write_type           = "All"
    include_management_events = true
  }

  tags = {
    Name        = "Organization-Security-Trail"
    Environment = "Landing-Zone"
  }
}

# 2. GuardDuty - Delegated Admin to Security account
resource "aws_guardduty_organization_admin_account" "this" {
  admin_account_id = var.security_account_id
}

# 3. Security Hub - Delegated Admin to Security account
resource "aws_securityhub_organization_admin_account" "this" {
  admin_account_id = var.security_account_id
}

# Temporarily disabled - enable after Security Hub is properly set up in delegated admin account
# resource "aws_securityhub_standards_subscription" "cis" {
#   standards_arn = "arn:aws:securityhub:${var.region}::standards/cis-aws-foundations-benchmark-v3.0.0"
# }

# resource "aws_securityhub_standards_subscription" "aws_foundational" {
#   standards_arn = "arn:aws:securityhub:${var.region}::standards/aws-foundational-security-best-practices"
# }