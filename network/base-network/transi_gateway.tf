module "tgw" {

  source = "github.com/binbashar/terraform-aws-transit-gateway?ref=0.4.0"

  count = var.enable_tgw ? 1 : 0
  name  = "${var.project}-tgw"

  ram_resource_share_enabled = true

  create_transit_gateway                                         = true
  create_transit_gateway_route_table                             = true
  create_transit_gateway_vpc_attachment                          = false
  create_transit_gateway_route_table_association_and_propagation = true

  config = merge(
    # network private
    lookup(var.enable_vpc_attach, "network", false) ? {
      for k, v in data.terraform_remote_state.network-vpcs : v.outputs.vpc_id => {
        vpc_id                            = null
        vpc_cidr                          = null
        subnet_ids                        = null
        subnet_route_table_ids            = null
        route_to                          = null
        route_to_cidr_blocks              = []
        transit_gateway_vpc_attachment_id = module.tgw_vpc_attachments_and_subnet_routes_network[0].transit_gateway_vpc_attachment_ids[k]
        static_routes = [
          {
            blackhole              = false
            destination_cidr_block = "0.0.0.0/0"
          },
        ]
      }
    } : {},
    # apps-devstg private
    lookup(var.enable_vpc_attach, "apps-devstg", false) ? {
      for k, v in data.terraform_remote_state.apps-devstg-vpcs : v.outputs.vpc_id => {
        vpc_id                            = null
        vpc_cidr                          = null
        subnet_ids                        = null
        subnet_route_table_ids            = null
        route_to                          = null
        route_to_cidr_blocks              = null
        transit_gateway_vpc_attachment_id = module.tgw_vpc_attachments_and_subnet_routes_apps-devstg[0].transit_gateway_vpc_attachment_ids[k]
        static_routes                     = null
      }
    } : {},
    # apps-prd private
    lookup(var.enable_vpc_attach, "apps-prd", false) ? {
      for k, v in data.terraform_remote_state.apps-prd-vpcs : v.outputs.vpc_id => {
        vpc_id                            = null
        vpc_cidr                          = null
        subnet_ids                        = null
        subnet_route_table_ids            = null
        route_to                          = null
        route_to_cidr_blocks              = null
        transit_gateway_vpc_attachment_id = module.tgw_vpc_attachments_and_subnet_routes_apps-prd[0].transit_gateway_vpc_attachment_ids[k]
        static_routes                     = null
      }
    } : {},
    # shared private
    lookup(var.enable_vpc_attach, "shared", false) ? {
      for k, v in data.terraform_remote_state.shared-vpcs : v.outputs.vpc_id => {
        vpc_id                            = null
        vpc_cidr                          = null
        subnet_ids                        = null
        subnet_route_table_ids            = null
        route_to                          = null
        route_to_cidr_blocks              = null
        transit_gateway_vpc_attachment_id = module.tgw_vpc_attachments_and_subnet_routes_shared[0].transit_gateway_vpc_attachment_ids[k]
        static_routes                     = null
      }
    } : {},
  )

  providers = {
    aws = aws.network
  }
}

# Update network public RT
resource "aws_route" "apps_devstg_public_route_to_tgw" {

  # For each vpc...
  for_each = data.terraform_remote_state.apps-devstg-vpcs

  # ...add a route into the network public RT
  route_table_id         = module.vpc.public_route_table_ids[0]
  destination_cidr_block = each.value.outputs.vpc_cidr_block
  transit_gateway_id     = module.tgw[0].transit_gateway_id

  depends_on = [module.tgw_vpc_attachments_and_subnet_routes_network]

}

resource "aws_route" "apps_prd_public_route_to_tgw" {

  # For each vpc...
  for_each = data.terraform_remote_state.apps-prd-vpcs

  # ...add a route into the network public RT
  route_table_id         = module.vpc.public_route_table_ids[0]
  destination_cidr_block = each.value.outputs.vpc_cidr_block
  transit_gateway_id     = module.tgw[0].transit_gateway_id

  depends_on = [module.tgw_vpc_attachments_and_subnet_routes_network]

}
