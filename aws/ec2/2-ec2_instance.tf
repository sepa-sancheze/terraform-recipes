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

# Subnet creation
resource "aws_subnet" "tf-Subnet" {
  vpc_id            = aws_vpc.tf-VPC.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = "us-east-1a"
  tags = {
    Name = "tf-Subnet"
  }
}

# Route Table Association Creation
resource "aws_route_table_association" "rf-RouteTableAssociation" {
  subnet_id      = aws_subnet.tf-Subnet.id
  route_table_id = aws_route_table.tf-RouteTable.id
}

# Security Group Creation
resource "aws_security_group" "tf-SecurityGroupWebServers" {
  name        = "allow_web_traffic"
  description = "Allow HTTP(s) and SSH connections"
  vpc_id      = aws_vpc.tf-VPC.id

  tags = {
    Name = "tf-SecurityGroupWebServers"
  }
}

# Security Group Ingress Rules Creation
resource "aws_vpc_security_group_ingress_rule" "tf-AllowHTTPS-Rule" {
  security_group_id = aws_security_group.tf-SecurityGroup.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "tcp"
  from_port         = 443
  to_port           = 443
}
resource "aws_vpc_security_group_ingress_rule" "tf-AllowHTTP-Rule" {
  security_group_id = aws_security_group.tf-SecurityGroup.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "tcp"
  from_port         = 80
  to_port           = 80
}
resource "aws_vpc_security_group_ingress_rule" "tf-AllowSSH-Rule" {
  security_group_id = aws_security_group.tf-SecurityGroup.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "tcp"
  from_port         = 22
  to_port           = 22
}

# Security Group Egress Rules Creation
resource "aws_vpc_security_group_egress_rule" "tf-AllowAllEgress-Rule" {
  security_group_id = aws_security_group.tf-SecurityGroup.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1"
}

# Network Interface Creation
resource "aws_network_interface" "tf-NetworkInterface" {
  subnet_id       = aws_subnet.tf-Subnet.id
  private_ips     = ["10.0.1.20"]
  security_groups = [aws_security_group.tf-SecurityGroupWebServers.id]
}
resource "aws_eip" "one" {
  domain            = "vpc"
  network_interface = aws_network_interface.tf-NetworkInterface.id
  depends_on        = [aws_internet_gateway.tf-InternetGateway]
}
