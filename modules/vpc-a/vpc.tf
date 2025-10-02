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
# Public Subnets
#############################################################

resource "aws_subnet" "public_subnet01" {
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = var.vpc_public_subnet_cidr[0]
  availability_zone = data.aws_availability_zones.available.names[0]

  tags = {
    Name = "${var.vpc_prefix}-public-subnet01"
  }
}


#############################################################
# IGW and Public Route Tables
#############################################################

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name = "${var.vpc_prefix}-internet-gateway"
  }
}

resource "aws_route_table" "public_rtb" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "${var.vpc_prefix}-public-rtb"
  }
}

resource "aws_route_table_association" "public_subnet01_association" {
  subnet_id      = aws_subnet.public_subnet01.id
  route_table_id = aws_route_table.public_rtb.id
}
