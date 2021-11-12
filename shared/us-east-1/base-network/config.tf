#=============================#
# AWS Provider Settings       #
#=============================#
provider "aws" {
  region                  = var.region
  profile                 = var.profile
  shared_credentials_file = "~/.aws/${var.project}/config"
}

provider "aws" {
  alias                   = "apps-devstg"
  region                  = var.region
  profile                 = "${var.project}-apps-devstg-devops"
  shared_credentials_file = "~/.aws/${var.project}/config"
}

provider "aws" {
  alias                   = "apps-devstg-dr"
  region                  = var.region_secondary
  profile                 = "${var.project}-apps-devstg-devops"
  shared_credentials_file = "~/.aws/${var.project}/config"
}

provider "aws" {
  alias                   = "apps-prd"
  region                  = var.region
  profile                 = "${var.project}-apps-prd-devops"
  shared_credentials_file = "~/.aws/${var.project}/config"
}

provider "aws" {
  alias                   = "apps-prd-dr"
  region                  = var.region_secondary
  profile                 = "${var.project}-apps-prd-devops"
  shared_credentials_file = "~/.aws/${var.project}/config"
}

provider "aws" {
  alias                   = "shared-dr"
  region                  = var.region_secondary
  profile                 = "${var.project}-apps-prd-devops"
  shared_credentials_file = "~/.aws/${var.project}/config"
}

#=============================#
# Backend Config (partial)    #
#=============================#
terraform {
  required_version = ">= 0.14.11"

  required_providers {
    aws = "~> 3.0"
  }

  backend "s3" {
    key = "shared/network/terraform.tfstate"
  }
}

#=============================#
# Data sources                #
#=============================#

#
# data type from output for tools-ec2
#
data "terraform_remote_state" "tools-vpn-server" {
  backend = "s3"

  config = {
    region  = var.region
    profile = var.profile
    bucket  = var.bucket
    key     = "${var.environment}/vpn/terraform.tfstate"
  }
}

# VPC remote states for network
data "terraform_remote_state" "network-vpcs" {
  for_each = local.network-vpcs

  backend = "s3"

  config = {
    region  = lookup(each.value, "region")
    profile = lookup(each.value, "profile")
    bucket  = lookup(each.value, "bucket")
    key     = lookup(each.value, "key")
  }
}

# VPC remote states for apps-devstg
data "terraform_remote_state" "apps-devstg-vpcs" {

  for_each = {
    for k, v in local.apps-devstg-vpcs :
    k => v if !v["tgw"]
  }

  backend = "s3"

  config = {
    region  = lookup(each.value, "region")
    profile = lookup(each.value, "profile")
    bucket  = lookup(each.value, "bucket")
    key     = lookup(each.value, "key")
  }
}

# VPC remote states for apps-devstg-dr
data "terraform_remote_state" "apps-devstg-dr-vpcs" {

  for_each = {
    for k, v in local.apps-devstg-dr-vpcs :
    k => v if !v["tgw"]
  }

  backend = "s3"

  config = {
    region  = lookup(each.value, "region")
    profile = lookup(each.value, "profile")
    bucket  = lookup(each.value, "bucket")
    key     = lookup(each.value, "key")
  }
}

# VPC remote states for apps-prd
data "terraform_remote_state" "apps-prd-vpcs" {

  for_each = {
    for k, v in local.apps-prd-vpcs :
    k => v if !v["tgw"]
  }

  backend = "s3"

  config = {
    region  = lookup(each.value, "region")
    profile = lookup(each.value, "profile")
    bucket  = lookup(each.value, "bucket")
    key     = lookup(each.value, "key")
  }
}

# VPC remote states for apps-prd-dr
data "terraform_remote_state" "apps-prd-dr-vpcs" {

  for_each = {
    for k, v in local.apps-prd-dr-vpcs :
    k => v if !v["tgw"]
  }

  backend = "s3"

  config = {
    region  = lookup(each.value, "region")
    profile = lookup(each.value, "profile")
    bucket  = lookup(each.value, "bucket")
    key     = lookup(each.value, "key")
  }
}

# VPC remote states for apps-devstg-dr
data "terraform_remote_state" "shared-dr-vpcs" {

  for_each = {
    for k, v in local.shared-dr-vpcs :
    k => v if !v["tgw"]
  }

  backend = "s3"

  config = {
    region  = lookup(each.value, "region")
    profile = lookup(each.value, "profile")
    bucket  = lookup(each.value, "bucket")
    key     = lookup(each.value, "key")
  }
}
