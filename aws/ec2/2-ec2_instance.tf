resource "aws_vpc" "tf_vpc" {
  cidr_block = "172.16.0.0/16"

  tags = {
    Name = "tf_vpc"
  }
}

resource "aws_subnet" "tf_subnet" {
  cidr_block        = "172.16.0.0/24"
  availability_zone = "us-east-1a"
  vpc_id            = aws_vpc.tf_vpc.id

  tags = {
    Name = "tf_subnet"
  }
}

resource "aws_instance" "tf_ec2-instance" {
  ami                         = "ami-04b70fa74e45c3917"
  instance_type               = "t2.micro"
  associate_public_ip_address = true
  subnet_id                   = aws_subnet.tf_subnet.id

  credit_specification {
    cpu_credits = "unlimited"
  }

  tags = {
    Name = "tf_ec2-example"
  }
}
