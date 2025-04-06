resource "aws_internet_gateway" "seefood-igw" {
  vpc_id = var.vpc_id

  tags = {
    Name = "seefood-igw"
  }
}