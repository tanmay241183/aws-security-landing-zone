# AWS Security Landing Zone with Terraform

A secure, modular AWS Landing Zone built manually step-by-step in VS Code.

## Overview
This project sets up a secure multi-account AWS Organization with:
- Dedicated **Security** and **Log Archive** accounts
- Organizational Units (OUs): Security, Logging, Workloads
- Central KMS key for encryption
- Baseline secure VPC with Flow Logs
- Strong IAM guardrails via Service Control Policies (SCPs)
- Foundation for CloudTrail, GuardDuty, Security Hub

**Region:** ap-southeast-2 (Sydney)

## Project Structure

aws-security-landing-zone/
├── main.tf
├── variables.tf
├── terraform.tfvars.example
├── providers.tf
├── versions.tf
├── backend.tf
├── README.md
├── .gitignore
└── modules/
├── organization/
├── security/
├── kms/
├── networking/
└── iam/


## Prerequisites
- AWS Management account with AdministratorAccess
- Terraform ≥ 1.9.0
- AWS CLI configured
- Unique email addresses for new accounts
- S3 bucket and DynamoDB table for remote state (created manually)

## Setup Steps
1. Copy `terraform.tfvars.example` to `terraform.tfvars` and update emails
2. `terraform init`
3. `terraform validate`
4. `terraform plan`
5. `terraform apply` (run multiple times as accounts become ACTIVE)

## Modules
- **organization**: AWS Org, OUs, and member accounts
- **kms**: Central KMS CMK with rotation
- **networking**: Secure baseline VPC + Flow Logs (encrypted)
- **iam**: SCP guardrails (deny root, require MFA)
- **security**: Delegated admin for GuardDuty, Security Hub, CloudTrail

## Next Steps
- Add cross-account provider aliases
- Central S3 logging bucket
- IAM Identity Center (SSO)
- More SCPs and conformance packs

Built manually in VS Code – April 2026
## Prerequisites
- AWS Management account with AdministratorAccess
- Terraform ≥ 1.9.0
- AWS CLI configured
- Unique email addresses for new accounts
- S3 bucket and DynamoDB table for remote state (created manually)

## Setup Steps
1. Copy `terraform.tfvars.example` to `terraform.tfvars` and update emails
2. `terraform init`
3. `terraform validate`
4. `terraform plan`
5. `terraform apply` (run multiple times as accounts become ACTIVE)

## Modules
- **organization**: AWS Org, OUs, and member accounts
- **kms**: Central KMS CMK with rotation
- **networking**: Secure baseline VPC + Flow Logs (encrypted)
- **iam**: SCP guardrails (deny root, require MFA)
- **security**: Delegated admin for GuardDuty, Security Hub, CloudTrail

## Next Steps
- Add cross-account provider aliases
- Central S3 logging bucket
- IAM Identity Center (SSO)
- More SCPs and conformance packs

Built manually in VS Code – April 2026