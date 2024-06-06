resource "aws_s3_bucket" "tf_s3_bucket" {
  # Name is excluded since it is complicated to find a unique name, so we let Terraform set a name
  tags = {
    Name        = "tf_s3-bucket"
    Environment = "development"
  }
}
