/* Using aws_vpc_security_group_egress_rule and aws_vpc_security_group_ingress_rule resources is the current best practice. 
Avoid using the aws_security_group_rule resource and the ingress and egress arguments of the aws_security_group resource for configuring in-line rules, 
as they struggle with managing multiple CIDR blocks, and tags and descriptions due to the historical lack of unique IDs. */

locals {
  ingress_rules = {
    ssh   = 22
    http  = 80
    https = 443
  }
}

resource "aws_security_group" "public_sg01" {
  name = "${var.vpc_prefix}-public-security-group01"

  vpc_id = aws_vpc.vpc.id

  tags = {
    Name = "${var.vpc_prefix}-public-security-group01"
  }
}

resource "aws_vpc_security_group_ingress_rule" "public_sg01_allow" {
  for_each = local.ingress_rules

  security_group_id = aws_security_group.public_sg01.id
  cidr_ipv4         = "0.0.0.0/0" # should be restricted to known IPs in production
  from_port         = each.value
  to_port           = each.value
  ip_protocol       = "tcp"
}

resource "aws_vpc_security_group_ingress_rule" "public_sg01_allow_all_icmp" {
  
  security_group_id = aws_security_group.public_sg01.id
  cidr_ipv4         = "0.0.0.0/0" # should be restricted to known IPs in production
  from_port         = 8
  to_port           = 0
  ip_protocol       = "icmp"
}

resource "aws_vpc_security_group_egress_rule" "public_sg01_allow_all_traffic" {
  security_group_id = aws_security_group.public_sg01.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1" # semantically equivalent to all ports
}
