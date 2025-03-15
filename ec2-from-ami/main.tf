data "aws_ami" "wordpress_ami" {

  filter {
    name   = "tag:Owner"
    values = ["061051228658"]
  }
}

data "aws_subnet" "web-A" {
  filter {
    name   = "tag:Name"
    values = ["sn-web-A"]
  }
}

data "aws_security_group" "a4l-demo-wordpress" {
  filter {
    name   = "group-name"
    values = ["AMIDEMO-InstanceSecurityGroup-mSRVcvjqTRMS"]
  }
}

resource "aws_instance" "InstanceFromAMI" {
  instance_type          = "t2.micro"
  ami                    = data.aws_ami.wordpress_ami.id
  availability_zone      = "us-east-1a"
  subnet_id              = data.aws_subnet.web-A.id
  vpc_security_group_ids = [data.aws_security_group.a4l-demo-wordpress.id]

  tags = {
    Name = "InstanceFromAMI"
  }
}