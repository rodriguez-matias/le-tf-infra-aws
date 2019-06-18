#
# Account Resources
#
module "aws_iam_account_config" {
  source = "git::git@github.com:binbashar/bb-devops-tf-modules.git//aws/iam-tf/modules/iam-account?ref=v0.6"

  // If IAM account alias was previously set (either via AWS console or during the creation of an account from AWS
  // Organizations) you will see this error:
  // * aws_iam_account_alias.this: Error creating account alias with name my-account-alias
  // please check https://github.com/binbashar/terraform-aws-iam/tree/master/modules/iam-account to solve it
  account_alias = "${var.project_long}-${var.environment}"

  # account password policy
  create_account_password_policy = true
  max_password_age               = 60
  minimum_password_length        = 16
  require_numbers                = true
  require_lowercase_characters   = true
  require_symbols                = true
  require_uppercase_characters   = true
  password_reuse_prevention      = true
  allow_users_to_change_password = true
}

data "aws_caller_identity" "current" {}
