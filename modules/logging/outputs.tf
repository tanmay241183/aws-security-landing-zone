output "cloudtrail_bucket_name" {
  description = "Name of the central CloudTrail S3 bucket"
  value       = aws_s3_bucket.cloudtrail_logs.bucket
}

output "cloudtrail_bucket_arn" {
  description = "ARN of the central CloudTrail S3 bucket"
  value       = aws_s3_bucket.cloudtrail_logs.arn
}

output "kms_key_arn" {
  description = "ARN of the KMS key used for bucket encryption"
  value       = var.kms_key_arn
}