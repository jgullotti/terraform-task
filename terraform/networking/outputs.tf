output "vpc_id" {
  value = aws_vpc.acme_vpc.id
}

output "public_sg" {
  value = aws_security_group.acme_sg["public"].id
}

output "acme_subnets" {
  value = aws_subnet.acme_subnet.*
}
