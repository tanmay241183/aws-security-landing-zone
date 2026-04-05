# AWS Security Landing Zone with Terraform

A secure, modular **AWS Landing Zone** built manually step-by-step in VS Code using Terraform.

## Overview

This project establishes a secure multi-account AWS environment with:
- Dedicated **Security** and **Log Archive** accounts
- Central KMS customer-managed key
- Organization-wide CloudTrail with encrypted logging
- Baseline secure VPC
- GuardDuty + Security Hub foundations
- SCP guardrails (ready to enable)

**Region**: `ap-southeast-2` (Sydney)

## Architecture

See **[architecture.md](architecture.md)** for the detailed Mermaid diagram.

## Key Components

- **Organization & OUs**: Security, Logging, Workloads
- **Logging**: Central encrypted S3 bucket in Log Archive account
- **Security Services**: GuardDuty and Security Hub (delegated)
- **Networking**: Private-by-default VPC baseline
- **Encryption**: All logs encrypted with customer-managed KMS

## Deployment

1. Copy `terraform.tfvars.example` → `terraform.tfvars` and update emails
2. `terraform init`
3. `terraform plan`
4. `terraform apply` (run multiple times as accounts become ACTIVE)

## Next Steps

- Re-enable VPC Flow Logs
- Activate SCP guardrails
- Set up IAM Identity Center (SSO)
- Add AWS Config aggregator

---

**Built manually step-by-step in VS Code** — April 2026