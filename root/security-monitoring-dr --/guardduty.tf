#
# We must first enable GuardDuty in the root account so it can be enabled
# later from GuardDuty's delegated admin.
#
# Also designate Security account as GuardDuty's delegated admin
#
module "guardduty" {
  source = "github.com/binbashar/terraform-aws-guardduty-multiaccount.git//modules/delegated-admin?ref=v0.0.3"

  guarduty_enabled                     = true
  guardduty_delegated_admin_account_id = var.security_account_id
}