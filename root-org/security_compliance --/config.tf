#=============================#
# AWS Provider Settings       #
#=============================#
provider "aws" {
  version                 = "~> 2.63"
  region                  = var.region
  profile                 = var.profile
  shared_credentials_file = "~/.aws/bb-le/config"
}

#=============================#
# Backend Config (partial)    #
#=============================#
terraform {
  required_version = ">= 0.12.24"

  backend "s3" {
    key = "root/securitycompliance/terraform.tfstate"
  }
}

variable "bucket_region" {
  description = "AWS Region"
  default     = "us-east-1"
}