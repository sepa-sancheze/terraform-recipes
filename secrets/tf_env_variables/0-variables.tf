variable "aws_access_key" {
  description = "Access Key for AWS Account"
  type        = string
  sensitive   = true
}

variable "aws_secret_key" {
  description = "Access Secret Key for AWS Account"
  type        = string
  sensitive   = true
}

variable "aws_region" {
  description = "Region to deploy resources"
  type        = string
  sensitive   = false
}
