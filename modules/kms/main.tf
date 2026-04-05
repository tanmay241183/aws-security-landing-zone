# modules/kms/main.tf
# Central Customer-Managed KMS Key for the Landing Zone

resource "aws_kms_key" "central" {
  description             = var.description
  deletion_window_in_days = 30
  enable_key_rotation     = var.enable_key_rotation
  is_enabled              = true

  # Policy that allows root, CloudTrail, and logging services to use the key
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid    = "EnableIAMUserPermissions"
        Effect = "Allow"
        Principal = {
          AWS = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:root"
        }
        Action   = "kms:*"
        Resource = "*"
      },
      {
        Sid    = "AllowCloudTrailAndLogging"
        Effect = "Allow"
        Principal = {
          Service = [
            "cloudtrail.amazonaws.com",
            "logs.amazonaws.com",
            "guardduty.amazonaws.com",
            "securityhub.amazonaws.com"
          ]
        }
        Action = [
          "kms:GenerateDataKey*",
          "kms:Decrypt",
          "kms:Encrypt",
          "kms:DescribeKey"
        ]
        Resource = "*"
      },
      {
        Sid    = "AllowS3AndOtherServices"
        Effect = "Allow"
        Principal = {
          AWS = "*"
        }
        Action = [
          "kms:GenerateDataKey*",
          "kms:Decrypt"
        ]
        Resource = "*"
        Condition = {
          StringEquals = {
            "aws:SourceAccount" = data.aws_caller_identity.current.account_id
          }
        }
      }
    ]
  })

  tags = {
    Name        = "Landing-Zone-Central-Key"
    Environment = "Security-Landing-Zone"
  }
}

resource "aws_kms_alias" "central" {
  name          = "alias/${var.key_alias}"
  target_key_id = aws_kms_key.central.key_id
}

# Get current account ID for the KMS policy
data "aws_caller_identity" "current" {}