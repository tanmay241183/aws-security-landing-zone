# AWS Security Landing Zone with Terraform

A secure, modular **AWS Landing Zone** built manually step-by-step in VS Code using Terraform.

## Overview

This project establishes a secure multi-account AWS environment following AWS Well-Architected best practices. It provides strong governance, centralized logging, encryption, and foundational security services.

**Region**: `ap-southeast-2` (Sydney)

### Key Features

- **AWS Organization** with dedicated **Security** and **Log Archive** accounts
- Organizational Units (OUs): Security, Logging, Workloads
- **Central KMS** customer-managed key with automatic rotation
- **Organization-wide CloudTrail** with logs stored in encrypted S3 bucket (Log Archive account)
- Baseline **secure VPC** (private subnets preferred, NAT gateway, Flow Logs ready)
- Service Control Policies (SCPs) for guardrails (deny root usage, require MFA, prevent public S3)
- Delegated administration for **GuardDuty** and **Security Hub**
- All logs encrypted with customer-managed KMS key

## Architecture

<grok-card data-id="b52740" data-type="image_card" data-plain-type="render_searched_image"  data-arg-image_id="kShp6"  data-arg-size="LARGE" ></grok-card>


<grok-card data-id="64267c" data-type="image_card" data-plain-type="render_searched_image"  data-arg-image_id="NOaLw"  data-arg-size="LARGE" ></grok-card>


**High-level Architecture**:
- **Management Account** → Owns the Organization
- **Log Archive Account** → Central encrypted S3 bucket for CloudTrail logs
- **Security Account** → Delegated admin for GuardDuty and Security Hub
- **Workloads OU** → Future application accounts (isolated by SCPs)

## Project Structure

```bash
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
    ├── iam/
    └── logging/

    Prerequisites

AWS Management account with AdministratorAccess
Terraform ≥ 1.9.0
AWS CLI v2 configured
Unique email addresses for new accounts (Gmail +tag recommended)
S3 bucket + DynamoDB (or use_lockfile = true) for remote state

Deployment Steps

Copy terraform.tfvars.example → terraform.tfvars and update emails
terraform init
terraform plan
terraform apply (run 2–3 times as accounts become ACTIVE)

Important: New AWS accounts take 5–20 minutes to become ACTIVE.
What's Included

Centralized encryption with KMS
Organization CloudTrail + secure logging bucket
Secure networking baseline
Foundational security services (GuardDuty, Security Hub)
SCP guardrails (ready to enable)

Next Steps (Recommended Enhancements)

Enable VPC Flow Logs with proper IAM role
Activate SCP attachments
Set up AWS IAM Identity Center (SSO)
Add AWS Config aggregator + conformance packs
Implement cross-account IAM roles
Add Transit Gateway for hub-and-spoke networking

Security Notes

SCPs are currently commented out (safe starting point)
All logs are encrypted with customer-managed KMS
Public access is blocked by default


Built manually step-by-step in VS Code — April 2026
Region: ap-southeast-2 (Sydney)