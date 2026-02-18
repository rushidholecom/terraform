terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = "ap-south-1"
}

# Create IAM User
resource "aws_iam_user" "dev_user" {
  name = "devops-user-terraform"
}

# Attach Policy (Example: Administrator Access)
resource "aws_iam_user_policy_attachment" "admin_attach" {
  user       = aws_iam_user.dev_user.name
  policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
}

# Create Login Profile (Console Password)
resource "aws_iam_user_login_profile" "login" {
  user    = aws_iam_user.dev_user.name
  password_reset_required = true
}

# Create Access Keys (Programmatic Access)
resource "aws_iam_access_key" "access_key" {
  user = aws_iam_user.dev_user.name
}

# Output Credentials
output "access_key_id" {
  value = aws_iam_access_key.access_key.id
}

output "secret_access_key" {
  value     = aws_iam_access_key.access_key.secret
  sensitive = true
}

output "console_login_url" {
  value = "https://${data.aws_caller_identity.current.account_id}.signin.aws.amazon.com/console"
}

data "aws_caller_identity" "current" {}