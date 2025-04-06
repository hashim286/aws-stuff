resource "aws_db_subnet_group" "seefood" {
  name       = "seefood-db-subnet"
  subnet_ids = var.subnet_ids
}

resource "aws_db_instance" "seefood-db" {
  allocated_storage      = 10
  identifier             = "seefood-db"
  db_name                = "seefood"
  engine                 = "mysql"
  engine_version         = "8.0"
  instance_class         = "db.t3.micro"
  username               = "username"
  password               = "test"
  db_subnet_group_name   = aws_db_subnet_group.seefood.name
  multi_az               = false
  availability_zone      = var.az
  publicly_accessible    = true
  skip_final_snapshot    = true
  vpc_security_group_ids = [var.sec_group_id]

  tags = {
    Name = "seefood-db"
  }
}