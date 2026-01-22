output "public_subnet_1_id" {
  value = aws_subnet.publicSubnetExample1.id
}

output "vpc_id" {
  value = aws_vpc.customVPC.id
}

output "subnet_rds_group_name" {
  value = aws_db_subnet_group.rds.name
}
