
resource "aws_security_group" "private_sg01" {
  name = "${var.vpc_prefix}-private-security-group01"

  vpc_id = aws_vpc.vpc.id

  tags = {
    Name = "${var.vpc_prefix}-private-security-group01"
  }
}

resource "aws_vpc_security_group_ingress_rule" "private_sg01_allow_all_ingress_traffic" {
  security_group_id = aws_security_group.private_sg01.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1" # semantically equivalent to all ports
}


resource "aws_vpc_security_group_ingress_rule" "private_sg01_allow_icmp" {
  security_group_id = aws_security_group.private_sg01.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 8
  ip_protocol       = "icmp"
  to_port           = 0
}

resource "aws_vpc_security_group_egress_rule" "private_sg01_allow_all_egress_traffic" {
  security_group_id = aws_security_group.private_sg01.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1" # semantically equivalent to all ports
}
