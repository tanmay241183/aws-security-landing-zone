output "guardduty_admin_account_id" {
  description = "Delegated admin account ID for GuardDuty"
  value       = aws_guardduty_organization_admin_account.this.admin_account_id
}

output "securityhub_admin_account_id" {
  description = "Delegated admin account ID for Security Hub"
  value       = aws_securityhub_organization_admin_account.this.admin_account_id
}

output "cloudtrail_trail_arn" {
  description = "ARN of the organization CloudTrail trail"
  value       = aws_cloudtrail.org_trail.arn
}