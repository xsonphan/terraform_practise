output "vpc_id"{
    value = aws_vpc.amie.id
}
output "public_subnet_1_id" {
  value = aws_subnet.public_subnet_1.id
}
output "public_subnet_2_id" {
  value = aws_subnet.public_subnet_2.id
}
output "private_subnet_1_id" {
  value = aws_subnet.private_subnet_1.id
}
output "private_subnet_2_id" {
  value = aws_subnet.private_subnet_2.id
}