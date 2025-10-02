
output "private_rtb01" {
  value = aws_route_table.private_rtb01.id
}


output "vpc_b_cidr_block" {
  value = var.vpc_cidr_address_space
}

output "vpc_id" {
  value = aws_vpc.vpc.id
}