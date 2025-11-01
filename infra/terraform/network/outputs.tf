output "vpc_id" {
  value = aws_vpc.main.id
}

output "public_a_id" {
  value = aws_subnet.public_a.id
}

output "private_a_id" {
  value = aws_subnet.private_a.id
}

output "private_b_id" {
  value = aws_subnet.private_b.id
}

output "sg_k3s_id" {
  value = aws_security_group.k3s_node.id
}
