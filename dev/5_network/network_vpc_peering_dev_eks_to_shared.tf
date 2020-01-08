#
# VPC Peering Connection with Share: Requester Side
#
# Consider 'destination_cidr_block' parameter will be the CIDR of the remote VPC/Subnets  (originator of the VPC
# peering request) and 'route_table_id' the route table ID to add the destination route to.
#

#
# VPC Dev-EKS w/ shared
#
resource "aws_vpc_peering_connection" "dev_eks_vpc_with_shared_vpc" {
  count = var.vpc_dev_eks_created == true ? 1 : 0

  peer_owner_id = var.shared_account_id
  peer_vpc_id   = data.terraform_remote_state.vpc-shared.outputs.vpc_id
  vpc_id        = data.terraform_remote_state.vpc-eks.outputs.vpc_id
  auto_accept   = false

  tags = merge(map("Name", "requester-dev-eks-to-shared"), local.tags)
}

#
# Update Route Tables to go through the VPC Peering Connection
#
resource "aws_route" "priv_route_table_1_dev_eks_vpc_to_shared_vpc" {
  count = var.vpc_dev_eks_created == true ? 1 : 0

  route_table_id            = element(data.terraform_remote_state.vpc-eks.outputs.private_route_table_ids, 0)
  destination_cidr_block    = data.terraform_remote_state.vpc-shared.outputs.vpc_cidr_block
  vpc_peering_connection_id = aws_vpc_peering_connection.dev_eks_vpc_with_shared_vpc[0].id
}

resource "aws_route" "pub_route_table_1_dev_eks_vpc_to_shared_vpc" {
  count = var.vpc_dev_eks_created == true ? 1 : 0

  route_table_id            = element(data.terraform_remote_state.vpc-eks.outputs.public_route_table_ids, 0)
  destination_cidr_block    = data.terraform_remote_state.vpc-shared.outputs.vpc_cidr_block
  vpc_peering_connection_id = aws_vpc_peering_connection.dev_eks_vpc_with_shared_vpc[0].id
}