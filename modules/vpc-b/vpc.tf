resource "aws_vpc" "vpc" {

  cidr_block           = var.vpc_cidr_address_space
  enable_dns_support   = true 
  enable_dns_hostnames = true

  tags = {
    Name        = "${var.vpc_prefix}-vpc"
    environment = "${var.vpc_environment}"
  }
}




#############################################################
# Private Subnets and Route Tables
#############################################################

resource "aws_subnet" "private_subnet01" {
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = var.vpc_private_subnet_cidr[0]
  availability_zone = data.aws_availability_zones.available.names[0]

  tags = {
    Name = "${var.vpc_prefix}-private-subnet01"
  }
}

resource "aws_route_table" "private_rtb01" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name = "${var.vpc_prefix}-private-rtb01"
  }
}

resource "aws_route_table_association" "private_subnet01_association" {
  subnet_id      = aws_subnet.private_subnet01.id
  route_table_id = aws_route_table.private_rtb01.id
}




