# modules/networking/main.tf
# Secure baseline VPC with private subnets preferred, Flow Logs encrypted with KMS

module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "~> 5.0"

  name = var.vpc_name
  cidr = var.cidr

  # Availability Zones - using 3 AZs in ap-southeast-2
  azs             = ["${var.region}a", "${var.region}b", "${var.region}c"]
  private_subnets = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
  public_subnets  = ["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"]

  # Internet access for private subnets via NAT
  enable_nat_gateway     = true
  single_nat_gateway     = true        # Cost-effective for baseline
  one_nat_gateway_per_az = false

  # DNS settings (recommended)
  enable_dns_hostnames = true
  enable_dns_support   = true

  # VPC Flow Logs - encrypted with central KMS key (security best practice)
  enable_flow_log                      = false
  flow_log_destination_type            = "cloud-watch-logs"
  flow_log_log_format                  = "$${version} $${vpc-id} $${subnet-id} $${instance-id} $${srcaddr} $${dstaddr} $${srcport} $${dstport} $${protocol} $${tcp-flags} $${type} $${pkt-srcaddr} $${pkt-dstaddr}"
  flow_log_cloudwatch_log_group_retention_in_days = 365
  flow_log_cloudwatch_log_group_kms_key_id        = var.kms_key_arn   # Encrypt logs with our KMS key

  tags = {
    Name        = var.vpc_name
    Environment = "Landing-Zone"
    ManagedBy   = "Terraform"
  }
}

# Restrictive default security group (blocks unnecessary ingress)
resource "aws_default_security_group" "default" {
  vpc_id = module.vpc.vpc_id

  # Allow communication within the security group
  ingress {
    protocol  = -1
    self      = true
    from_port = 0
    to_port   = 0
  }

  # Allow all outbound traffic (standard practice)
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.vpc_name}-default-sg"
  }
}