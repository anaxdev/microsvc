variable "vpc_cidr_block" {
  description = "The CIDR block for the VPC."
  default     = "10.0.0.0/16"
}

variable "subnet_cidr_block" {
  description = "The CIDR block for the subnet"
  default     = "10.0.1.0/24"
}

variable "name_prefix" {
  description = "The prefix for the name of network resources such as VPC, Subnet, Gateway, etc."
  type        = string
}

variable "environment" {
  description = "The environment type being created"
  type        = string
}
