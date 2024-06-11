# VPC Creation
resource "aws_vpc" "tf-VPC" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Name = "tf-VPC"
  }
}

# Internet Gateway Creation
resource "aws_internet_gateway" "tf-InternetGateway" {
  vpc_id = aws_vpc.tf-VPC.id

  tags = {
    Name = "tf-InternetGateway"
  }
}

# Route Table Creation
resource "aws_route_table" "tf-RouteTable" {
  vpc_id = aws_vpc.tf-VPC.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.tf-InternetGateway.id
  }

  route {
    ipv6_cidr_block        = "::/0"
    egress_only_gateway_id = aws_internet_gateway.tf-InternetGateway.id
  }

  tags = {
    Name = "tf-RouteTable"
  }
}
