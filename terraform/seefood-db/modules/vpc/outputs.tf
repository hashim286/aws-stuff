output "vpc_id" {
  value = aws_vpc.seefood.id
}

output "subnet_ids" {
  value = [aws_subnet.seefood-db.id, aws_subnet.backup.id, aws_subnet.backup2.id]
}

output "subnet_id" {
  value = aws_subnet.seefood-db.id
}

output "az" {
  value = aws_subnet.seefood-db.availability_zone
}