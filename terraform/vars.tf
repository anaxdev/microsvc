variable "aws_region" {
  default = "us-east-2"
}

# variable "aws_access_key" {
#   type = string
# }

# variable "aws_secret_key" {
#   type = string
# }

# variable "aws_session_token" {
#   type = string
# }

variable "private_key_name" {
  default = "aws_key"
}

variable "public_key_name" {
  default = "aws_key.pub"
}

variable "name_prefix" {
  type = string
}

variable "ec2_instance_name" {
  type = string
}

variable "environment" {
  default = "development"
}
