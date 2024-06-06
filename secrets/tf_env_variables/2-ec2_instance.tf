resource "aws_instance" "helloworld-terraform" {
  ami                    = "ami-04b70fa74e45c3917"
  instance_type          = "t2.micro"
  subnet_id              = "subnet-01517c11893830013"
  vpc_security_group_ids = ["sg-09b6f2305aafea2c1"]
}
