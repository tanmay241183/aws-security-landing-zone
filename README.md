# AWS Security Landing Zone with Terraform

A secure, modular **AWS Landing Zone** built manually step-by-step in VS Code using Terraform.

## Overview

This project establishes a secure multi-account AWS environment following AWS Well-Architected and Landing Zone best practices.

**Region**: `ap-southeast-2` (Sydney)

### Key Features

- AWS Organization with dedicated **Security** and **Log Archive** accounts
- Organizational Units: Security, Logging, Workloads
- Central **KMS** customer-managed key with rotation
- **Organization-wide CloudTrail** with encrypted logs in Log Archive account
- Baseline secure **VPC** (private subnets, NAT gateway)
- Service Control Policies (SCPs) for governance (ready to enable)
- Delegated administration for **GuardDuty** and **Security Hub**

## Architecture

![AWS Security Landing Zone Architecture](architecture.png)

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