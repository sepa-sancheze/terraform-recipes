variable "access_key" {
  description = "Access Key for AWS Account"
  type        = string
  sensitive   = true
}

variable "secret_key" {
  description = "Access Secret Key for AWS Account"
  type        = string
  sensitive   = true
}

variable "region" {
  description = "Region to deploy resources"
  type        = string
  sensitive   = false
}
