output "kms_key_arn" {
  description = "ARN of the central KMS key"
  value       = aws_kms_key.central.arn
}

output "kms_key_id" {
  description = "Key ID of the central KMS key"
  value       = aws_kms_key.central.key_id
}

output "kms_alias_name" {
  description = "Alias name of the KMS key"
  value       = aws_kms_alias.central.name
}