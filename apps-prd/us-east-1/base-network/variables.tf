#
# config/backend.config
#
#================================#
# Terraform AWS Backend Settings #
#================================#
variable "region" {
  type        = string
  description = "AWS Region"
}

variable "profile" {
  type        = string
  description = "AWS Profile (required by the backend but also used for other resources)"
}

variable "bucket" {
  type        = string
  description = "AWS S3 TF State Backend Bucket"
}

variable "dynamodb_table" {
  type        = string
  description = "AWS DynamoDB TF Lock state table name"
}

variable "encrypt" {
  type        = bool
  description = "Enable AWS DynamoDB with server side encryption"
}

#
# config/base.config
#
#=============================#
# Project Variables           #
#=============================#
variable "project" {
  type        = string
  description = "Project Name"
}

variable "project_long" {
  type        = string
  description = "Project Long Name"
}

variable "environment" {
  type        = string
  description = "Environment Name"
}

#
# config/extra.config
#
#=============================#
# Accounts & Extra Vars       #
#=============================#
variable "region_secondary" {
  type        = string
  description = "AWS Scondary Region for HA"
}

variable "root_account_id" {
  type        = string
  description = "Account: Root"
}

variable "security_account_id" {
  type        = string
  description = "Account: Security & Users Management"
}

variable "shared_account_id" {
  type        = string
  description = "Account: Shared Resources"
}

variable "network_account_id" {
  type        = string
  description = "Account: Networking Resources"
}

variable "appsdevstg_account_id" {
  type        = string
  description = "Account: Dev Modules & Libs"
}

variable "appsprd_account_id" {
  type        = string
  description = "Account: Prod Modules & Libs"
}

#===========================================#
# Networking                                #
#===========================================#
variable "vpc_shared_created" {
  description = "true if Shared account VPC is created for Peering purposes"
  type        = bool
  default     = true
}

variable "vpc_enable_nat_gateway" {
  description = "Enable NAT Gatewway"
  type        = bool
  default     = false
}

variable "vpc_single_nat_gateway" {
  description = "Single NAT Gatewway"
  type        = bool
  default     = true
}

variable "vpc_enable_dns_hostnames" {
  description = "Enable DNS HOSTNAME"
  type        = bool
  default     = true
}

variable "vpc_enable_vpn_gateway" {
  description = "Enable VPN Gateway"
  type        = bool
  default     = false
}

variable "vpc_enable_s3_endpoint" {
  description = "Enable S3 endpoint"
  type        = bool
  default     = true
}

variable "vpc_enable_dynamodb_endpoint" {
  description = "Enable DynamoDB endpoint"
  type        = bool
  default     = true
}

variable "enable_kms_endpoint" {
  description = "Enable KMS endpoint"
  type        = bool
  default     = false
}

variable "enable_kms_endpoint_private_dns" {
  description = "Enable KMS endpoint"
  type        = bool
  default     = false
}

variable "manage_default_network_acl" {
  description = "Manage default Network ACL"
  type        = bool
  default     = false
}

variable "public_dedicated_network_acl" {
  description = "Manage default Network ACL"
  type        = bool
  default     = true
}

variable "private_dedicated_network_acl" {
  description = "Manage default Network ACL"
  type        = bool
  default     = true
}

variable "enable_tgw" {
  description = "Enable Transit Gateway Support"
  type        = bool
  default     = false
}