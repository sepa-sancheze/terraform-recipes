resource "aws_vpc" "tf_vpc" {
  cidr_block = "172.16.0.0/16"

  tags = {
    Name = "tf_vpc-example"
  }
}

resource "aws_subnet" "tf_subnet" {
  vpc_id            = aws_vpc.tf_vpc.id
  cidr_block        = "172.16.0.0/24"
  availability_zone = "us-east-1a"

  tags = {
    Name = "tf_subnet-example"
  }
}

resource "aws_network_interface" "tf_network-interface" {
  subnet_id   = aws_subnet.tf_subnet.id
  private_ips = ["172.16.0.100"]

  tags = {
    Name = "tf_primary-network-interface"
  }
}

resource "aws_instance" "tf_ec2-instance" {
  ami           = "ami-04b70fa74e45c3917"
  instance_type = "t2.micro"

  network_interface {
    network_interface_id = aws_network_interface.tf_network-interface.id
    device_index         = 0
  }

  credit_specification {
    cpu_credits = "unlimited"
  }

  tags = {
    Name = "tf_ec2-example"
  }
}
