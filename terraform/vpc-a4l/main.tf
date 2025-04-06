resource "aws_vpc" "test" {
  cidr_block                       = "10.16.0.0/16"
  assign_generated_ipv6_cidr_block = "true"
  enable_dns_hostnames             = "true"

  tags = {
    Name = "test-from-terraform"
  }
}

resource "aws_subnet" "sn-reserved-A" {
  vpc_id                          = aws_vpc.test.id
  cidr_block                      = "10.16.0.0/20"
  assign_ipv6_address_on_creation = "true"
  availability_zone               = "us-east-1a"
  ipv6_cidr_block                 = cidrsubnet(aws_vpc.test.ipv6_cidr_block, 8, 0)

  tags = {
    Name = "sn-reserved-A"
  }
}

resource "aws_subnet" "sn-reserved-B" {
  vpc_id                          = aws_vpc.test.id
  cidr_block                      = "10.16.64.0/20"
  availability_zone               = "us-east-1b"
  assign_ipv6_address_on_creation = "true"
  ipv6_cidr_block                 = cidrsubnet(aws_vpc.test.ipv6_cidr_block, 8, 4)

  tags = {
    Name = "sn-reserved-B"
  }
}

resource "aws_subnet" "sn-reserved-C" {
  vpc_id                          = aws_vpc.test.id
  availability_zone               = "us-east-1c"
  cidr_block                      = "10.16.128.0/20"
  assign_ipv6_address_on_creation = "true"
  ipv6_cidr_block                 = cidrsubnet(aws_vpc.test.ipv6_cidr_block, 8, 8)

  tags = {
    Name = "sn-reserved-C"
  }
}

resource "aws_subnet" "sn-db-A" {
  vpc_id                          = aws_vpc.test.id
  assign_ipv6_address_on_creation = "true"
  cidr_block                      = "10.16.16.0/20"
  availability_zone               = "us-east-1a"
  ipv6_cidr_block                 = cidrsubnet(aws_vpc.test.ipv6_cidr_block, 8, 1)


  tags = {
    Name = "sn-db-A"
  }
}


resource "aws_subnet" "sn-db-B" {
  vpc_id                          = aws_vpc.test.id
  assign_ipv6_address_on_creation = "true"
  cidr_block                      = "10.16.80.0/20"
  availability_zone               = "us-east-1b"
  ipv6_cidr_block                 = cidrsubnet(aws_vpc.test.ipv6_cidr_block, 8, 5)

  tags = {
    Name = "sn-db-B"
  }
}


resource "aws_subnet" "sn-db-C" {
  vpc_id                          = aws_vpc.test.id
  cidr_block                      = "10.16.144.0/20"
  assign_ipv6_address_on_creation = "true"
  ipv6_cidr_block                 = cidrsubnet(aws_vpc.test.ipv6_cidr_block, 8, 9)
  availability_zone               = "us-east-1c"

  tags = {
    Name = "sn-db-C"
  }
}


resource "aws_subnet" "sn-app-A" {
  vpc_id                          = aws_vpc.test.id
  cidr_block                      = "10.16.32.0/20"
  assign_ipv6_address_on_creation = "true"
  ipv6_cidr_block                 = cidrsubnet(aws_vpc.test.ipv6_cidr_block, 8, 2)
  availability_zone               = "us-east-1a"

  tags = {
    Name = "sn-app-A"
  }
}

resource "aws_subnet" "sn-app-B" {
  vpc_id                          = aws_vpc.test.id
  cidr_block                      = "10.16.96.0/20"
  assign_ipv6_address_on_creation = "true"
  ipv6_cidr_block                 = cidrsubnet(aws_vpc.test.ipv6_cidr_block, 8, 6)
  availability_zone               = "us-east-1b"

  tags = {
    Name = "sn-app-B"
  }
}

resource "aws_subnet" "sn-app-C" {
  vpc_id                          = aws_vpc.test.id
  cidr_block                      = "10.16.160.0/20"
  assign_ipv6_address_on_creation = "true"
  ipv6_cidr_block                 = cidrsubnet(aws_vpc.test.ipv6_cidr_block, 8, 10)
  availability_zone               = "us-east-1c"

  tags = {
    Name = "sn-app-C"
  }
}

resource "aws_subnet" "sn-web-A" {
  vpc_id                          = aws_vpc.test.id
  cidr_block                      = "10.16.48.0/20"
  map_public_ip_on_launch = "true"
  assign_ipv6_address_on_creation = "true"
  ipv6_cidr_block                 = cidrsubnet(aws_vpc.test.ipv6_cidr_block, 8, 3)
  availability_zone               = "us-east-1a"

  tags = {
    Name = "sn-web-A"
  }
}

resource "aws_subnet" "sn-web-B" {
  vpc_id                          = aws_vpc.test.id
  cidr_block                      = "10.16.112.0/20"
  assign_ipv6_address_on_creation = "true"
  map_public_ip_on_launch = "true"
  ipv6_cidr_block                 = cidrsubnet(aws_vpc.test.ipv6_cidr_block, 8, 7)
  availability_zone               = "us-east-1b"

  tags = {
    Name = "sn-web-B"
  }
}

resource "aws_subnet" "sn-web-C" {
  vpc_id                          = aws_vpc.test.id
  cidr_block                      = "10.16.176.0/20"
  assign_ipv6_address_on_creation = "true"
  map_public_ip_on_launch = "true"
  ipv6_cidr_block                 = cidrsubnet(aws_vpc.test.ipv6_cidr_block, 8, 11)
  availability_zone               = "us-east-1c"

  tags = {
    Name = "sn-web-C"
  }
}

resource "aws_internet_gateway" "name" {
  vpc_id = aws_vpc.test.id

  tags = {
    Name = "test-igw"
  }
}

resource "aws_route_table" "test-vpc1-rt-web" {
  vpc_id = aws_vpc.test.id

  tags = {
    Name = "test-vpc1-rt-web"
  }

}

resource "aws_route" "default-v4" {
  route_table_id         = aws_route_table.test-vpc1-rt-web.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.name.id
}

resource "aws_route" "default-v6" {
  route_table_id              = aws_route_table.test-vpc1-rt-web.id
  destination_ipv6_cidr_block = "::/0"
  gateway_id                  = aws_internet_gateway.name.id
}

resource "aws_route_table_association" "web-a" {
  route_table_id = aws_route_table.test-vpc1-rt-web.id
  subnet_id      = aws_subnet.sn-web-A.id
}

resource "aws_route_table_association" "web-b" {
  route_table_id = aws_route_table.test-vpc1-rt-web.id
  subnet_id      = aws_subnet.sn-web-B.id
}

resource "aws_route_table_association" "web-c" {
  route_table_id = aws_route_table.test-vpc1-rt-web.id
  subnet_id      = aws_subnet.sn-web-C.id
}

data "aws_ami" "ubuntu" {
  most_recent = true
  owners      = ["amazon"]

}

resource "aws_network_interface" "test" {
  subnet_id = aws_subnet.sn-web-A.id
}

resource "aws_security_group" "allow-icmp" {
  name        = "allow-icmp"
  description = "allows icmp in"
  vpc_id      = aws_vpc.test.id

  tags = {
    Name = "allow-icmp"
  }
}

resource "aws_instance" "test-instance" {

  depends_on                  = [aws_security_group.allow-icmp]
  ami                         = data.aws_ami.ubuntu.id
  instance_type               = "t2.micro"
  availability_zone           = "us-east-1a"
  subnet_id                   = aws_subnet.sn-web-A.id
  vpc_security_group_ids      = [aws_security_group.allow-icmp.id]

  tags = {
    Name = "test-instance-from-terraform"
  }
}

resource "aws_vpc_security_group_ingress_rule" "allow-icmp-in" {
  security_group_id = aws_security_group.allow-icmp.id

  cidr_ipv4   = "0.0.0.0/0"
  ip_protocol = -1
}

resource "aws_vpc_security_group_ingress_rule" "allow-icmp6-in" {
  security_group_id = aws_security_group.allow-icmp.id

  cidr_ipv6   = "::/0"
  ip_protocol = -1
}

output "ipv4_address" {
  value = aws_instance.test-instance.*.public_ip
}

output "ipv6_address" {
  value = aws_instance.test-instance.ipv6_addresses
}