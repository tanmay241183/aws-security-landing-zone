output "deny_member_root_policy_id" {
  description = "ID of the SCP that denies root user actions in member accounts"
  value       = aws_organizations_policy.deny_member_root.id
}

output "require_mfa_policy_id" {
  description = "ID of the SCP that requires MFA for IAM actions"
  value       = aws_organizations_policy.require_mfa.id
}