output "organization_id" {
  description = "ID of the AWS Organization"
  value       = data.aws_organizations_organization.this.id
}

output "security_account_id" {
  description = "Account ID of the Security Audit account"
  value       = aws_organizations_account.security.id
}

output "log_archive_account_id" {
  description = "Account ID of the Log Archive account"
  value       = aws_organizations_account.logs.id
}

output "security_ou_id" {
  description = "ID of the Security OU"
  value       = aws_organizations_organizational_unit.security.id
}

output "logging_ou_id" {
  description = "ID of the Logging OU"
  value       = aws_organizations_organizational_unit.logging.id
}

output "workloads_ou_id" {
  description = "ID of the Workloads OU"
  value       = aws_organizations_organizational_unit.workloads.id
}