# modules/iam/main.tf
# Strong Service Control Policies (SCPs) for the entire organization

# SCP 1: Deny root user actions in all member accounts (except Management account)
resource "aws_organizations_policy" "deny_member_root" {
  name        = "Deny-Member-Account-Root-Actions"
  description = "Prevent use of root user credentials in all member accounts"
  type        = "SERVICE_CONTROL_POLICY"

  content = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Sid       = "DenyRootUser"
      Effect    = "Deny"
      Action    = "*"
      Resource  = "*"
      Condition = {
        StringLike = {
          "aws:PrincipalARN" = "arn:aws:iam::*:root"
        }
      }
    }]
  })
}

# SCP 2: Require MFA for all IAM actions (except MFA management itself)
resource "aws_organizations_policy" "require_mfa" {
  name        = "Require-MFA-for-IAM-Actions"
  description = "Block IAM actions unless MFA is present"
  type        = "SERVICE_CONTROL_POLICY"

  content = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Sid       = "DenyNonMFAActions"
      Effect    = "Deny"
      NotAction = [
        "iam:CreateVirtualMFADevice",
        "iam:EnableMFADevice",
        "iam:ResyncMFADevice",
        "iam:DeleteVirtualMFADevice",
        "iam:ListMFADevices",
        "iam:DeactivateMFADevice"
      ]
      Resource  = "*"
      Condition = {
        BoolIfExists = {
          "aws:MultiFactorAuthPresent" = "false"
        }
      }
    }]
  })
}

# SCP 3: Deny public S3 buckets and ACLs (additional security layer)
resource "aws_organizations_policy" "deny_public_s3" {
  name        = "Deny-Public-S3-Buckets"
  description = "Prevent creation of public S3 buckets and ACLs"
  type        = "SERVICE_CONTROL_POLICY"

  content = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Sid       = "DenyPublicS3"
      Effect    = "Deny"
      Action    = [
        "s3:PutBucketAcl",
        "s3:PutBucketPolicy",
        "s3:PutBucketPublicAccessBlock"
      ]
      Resource  = "*"
      Condition = {
        StringEquals = {
          "s3:PublicAccess" = "true"
        }
      }
    }]
  })
}

# Temporarily disabled - attachment pattern issue with existing organization
# Uncomment later when ready

# resource "aws_organizations_policy_attachment" "root_deny_root" {
#   policy_id = aws_organizations_policy.deny_member_root.id
#   target_id = var.organization_id
# }

# resource "aws_organizations_policy_attachment" "root_require_mfa" {
#   policy_id = aws_organizations_policy.require_mfa.id
#   target_id = var.organization_id
# }

# resource "aws_organizations_policy_attachment" "root_deny_public_s3" {
#   policy_id = aws_organizations_policy.deny_public_s3.id
#   target_id = var.organization_id
# }