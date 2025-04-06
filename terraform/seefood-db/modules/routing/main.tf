resource "aws_route_table" "seefood-rt" {
  vpc_id = var.vpc_id

  tags = {
    Name = "seefood-rt"
  }
}

resource "aws_route" "seefood-rt-def" {
  route_table_id         = aws_route_table.seefood-rt.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = var.igw_id
}

resource "aws_route_table_association" "db-sub" {
  route_table_id = aws_route_table.seefood-rt.id
  subnet_id      = var.subnet_id
}