resource "aws_vpc_peering_connection" "peering_vpc_a_to_c" {
  provider = aws.account-A
  vpc_id        = module.vpc-A.vpc_id
  peer_vpc_id   = module.vpc-C.vpc_id
  peer_owner_id = data.aws_caller_identity.account-b.account_id
  peer_region   = var.cross_acc_peering_region
  
  
  tags = {
    Name = "${var.vpca_prefix}-peering-requester-to-vpcc"
    Side = "Requester"
  }
}

resource "aws_vpc_peering_connection_accepter" "vpcc_peering_accepter" {

  provider = aws.account-B
  vpc_peering_connection_id = aws_vpc_peering_connection.peering_vpc_a_to_c.id
  auto_accept               = true

  
  
  tags = {
    Name = "vpcc-peering-accepter"
    Side = "Accepter"
  }
}

resource "aws_vpc_peering_connection_options" "vpca_to_vpc_requestor_allow_dns" {
  vpc_peering_connection_id = aws_vpc_peering_connection_accepter.vpcc_peering_accepter.id
  provider                  = aws.account-A

  requester {
    allow_remote_vpc_dns_resolution = true
  }
  depends_on = [aws_vpc_peering_connection_accepter.vpcc_peering_accepter]
}

resource "aws_vpc_peering_connection_options" "vpca_to_vpcc_accepter_allow_dns" {
  vpc_peering_connection_id = aws_vpc_peering_connection_accepter.vpcc_peering_accepter.id
  provider                  = aws.account-B

  accepter {
    allow_remote_vpc_dns_resolution = true
  }

  depends_on = [aws_vpc_peering_connection_accepter.vpcc_peering_accepter]
}

resource "aws_route" "vpca_to_vpcc" {
  provider                  = aws.account-A
  route_table_id            = module.vpc-A.public_rtb
  destination_cidr_block    = module.vpc-C.vpc_c_cidr_block
  vpc_peering_connection_id = aws_vpc_peering_connection.peering_vpc_a_to_c.id
}
 
resource "aws_route" "vpcc_to_vpca" {
  provider                  = aws.account-B
  route_table_id            = module.vpc-C.private_rtb01
  destination_cidr_block    = module.vpc-A.vpc_a_cidr_block
  vpc_peering_connection_id = aws_vpc_peering_connection.peering_vpc_a_to_c.id
}
