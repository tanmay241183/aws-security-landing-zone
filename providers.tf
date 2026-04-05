# Main provider for the AWS Management (root) account
provider "aws" {
  region = "ap-southeast-2"
}

# You can add alias providers later when we need to target the new Security and Log Archive accounts
# Example (uncomment and adjust when ready):
# provider "aws" {
#   alias  = "security"
#   region = "ap-southeast-2"
#   # assume_role block will be added once accounts exist
# }