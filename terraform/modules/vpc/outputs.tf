output "id" {
  description = "The id of the provisioned VPC"
  value       = aws_vpc.app_vpc.id
}

output "subnet" {
  description = "Subnet under the provisioned VPC"
  value       = aws_subnet.app_subnet.id
}
