
output "vpc_id" {
  value = aws_vpc.dev_vpc.id
}

output "subnet_id" {
  value = aws_subnet.dev_subnet.id
}

output "security_group_id" {
  value = aws_security_group.dev_sg.id
}

