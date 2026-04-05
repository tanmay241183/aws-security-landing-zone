# Since the organization already exists (o-lux3gv9h3s), we import it and make it read-only
# Do NOT try to create or modify service access here
data "aws_organizations_organization" "this" {}

# Keep the OUs and accounts as they are (they are still useful)
resource "aws_organizations_organizational_unit" "security" {
  name      = "Security"
  parent_id = data.aws_organizations_organization.this.roots[0].id
}

resource "aws_organizations_organizational_unit" "logging" {
  name      = "Logging"
  parent_id = data.aws_organizations_organization.this.roots[0].id
}

resource "aws_organizations_organizational_unit" "workloads" {
  name      = "Workloads"
  parent_id = data.aws_organizations_organization.this.roots[0].id
}

# Accounts (these can still be created if not present)
resource "aws_organizations_account" "logs" {
  name              = "Log-Archive"
  email             = var.log_archive_email
  parent_id         = aws_organizations_organizational_unit.logging.id
  close_on_deletion = true
}

resource "aws_organizations_account" "security" {
  name              = "Security-Audit"
  email             = var.security_audit_email
  parent_id         = aws_organizations_organizational_unit.security.id
  close_on_deletion = true
}