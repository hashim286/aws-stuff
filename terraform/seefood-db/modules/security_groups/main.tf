resource "aws_security_group" "seefood-db" {
  name        = "allow-db-traffic"
  description = "allows db traffic in"
  vpc_id      = var.vpc_id

  tags = {
    Name = "allow-db"
  }
}


resource "aws_vpc_security_group_ingress_rule" "allow-db-in" {
  security_group_id = aws_security_group.seefood-db.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "tcp"
  from_port         = "3306"
  to_port           = "3306"
}