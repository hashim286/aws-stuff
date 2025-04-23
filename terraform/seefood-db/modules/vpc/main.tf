resource "aws_vpc" "seefood" {
  cidr_block           = var.vpc_cidr_block
  enable_dns_hostnames = "true"

  tags = {
    Name = "seefood"
  }
}

resource "aws_subnet" "seefood-db" {
  vpc_id            = aws_vpc.seefood.id
  cidr_block        = cidrsubnet(var.vpc_cidr_block, 4, 0)
  availability_zone = "${var.default_region}a"

  tags = {
    Name = "seefood-db"
  }
}

# subnet groups require at least 3 subnets in different AZs for the multi-az deployment regardless of if you actually use it so I had to define some extras here as just "backup" even though I only planned to use 1
resource "aws_subnet" "backup" {
  vpc_id            = aws_vpc.seefood.id
  cidr_block        = cidrsubnet(var.vpc_cidr_block, 4, 1)
  availability_zone = "${var.default_region}b"

  tags = {
    Name = "backup"
  }
}

resource "aws_subnet" "backup2" {
  vpc_id            = aws_vpc.seefood.id
  cidr_block        = cidrsubnet(var.vpc_cidr_block, 4, 2)
  availability_zone = "${var.default_region}c"

  tags = {
    Name = "backup2"
  }
}
