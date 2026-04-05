terraform {
  backend "s3" {
    bucket         = "tfstate-tanmay-landingzone"   # ← Make sure this matches your actual bucket name
    key            = "landing-zone/terraform.tfstate"
    region         = "ap-southeast-2"
    encrypt        = true
    use_lockfile   = true      # New recommended way (replaces dynamodb_table)
  }
}