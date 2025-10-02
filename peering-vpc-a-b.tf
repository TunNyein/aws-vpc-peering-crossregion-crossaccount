resource "aws_vpc_peering_connection" "peering_vpc_a_to_b" {
  provider = aws.account-A
  vpc_id        = module.vpc-A.vpc_id
  peer_vpc_id   = module.vpc-B.vpc_id
  auto_accept   = true

  
  requester {
    allow_remote_vpc_dns_resolution = true
  }

  tags = {
    Name = "${var.vpca_prefix}-peering-requester"
    Side = "Requester"
  }
}

resource "aws_vpc_peering_connection_accepter" "vpcb_peering_accepter" {
  provider = aws.account-A
  vpc_peering_connection_id = aws_vpc_peering_connection.peering_vpc_a_to_b.id
  auto_accept               = true

  accepter {
    allow_remote_vpc_dns_resolution = true
  }
  
  tags = {
    Name = "vpcb-peering-accepter"
    Side = "Accepter"
  }
}


resource "aws_route" "vpca_to_vpcb" {
  provider                  = aws.account-A
  route_table_id            = module.vpc-A.public_rtb
  destination_cidr_block    = module.vpc-B.vpc_b_cidr_block
  vpc_peering_connection_id = aws_vpc_peering_connection.peering_vpc_a_to_b.id
}


resource "aws_route" "vpcb_to_vpca" {
  provider                  = aws.account-A
  route_table_id            = module.vpc-B.private_rtb01
  destination_cidr_block    = module.vpc-A.vpc_a_cidr_block
  vpc_peering_connection_id = aws_vpc_peering_connection.peering_vpc_a_to_b.id
}


