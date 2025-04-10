resource "aws_vpc" "seefood" {
  cidr_block           = "10.39.0.0/16"
  enable_dns_hostnames = "true"

  tags = {
    Name = "seefood"
  }
}

resource "aws_subnet" "seefood-db" {
  vpc_id            = aws_vpc.seefood.id
  cidr_block        = "10.39.0.0/20"
  availability_zone = "us-east-1a"

  tags = {
    Name = "seefood-db"
  }
}

# subnet groups require at least 3 subnets in different AZs for the multi-az deployment regardless of if you actually use it so I had to define some extras here as just "backup" even though I only planned to use 1
resource "aws_subnet" "backup" {
  vpc_id            = aws_vpc.seefood.id
  cidr_block        = "10.39.16.0/20"
  availability_zone = "us-east-1b"

  tags = {
    Name = "backup"
  }
}

resource "aws_subnet" "backup2" {
  vpc_id            = aws_vpc.seefood.id
  cidr_block        = "10.39.32.0/20"
  availability_zone = "us-east-1c"

  tags = {
    Name = "backup2"
  }
}
