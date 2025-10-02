output "public_rtb" {
  value = aws_route_table.public_rtb.id
}

output "vpc_a_cidr_block" {
  value = var.vpc_cidr_address_space
}

output "vpc_id" {
  value = aws_vpc.vpc.id
}