output "server_ip" {
  value = aws_instance.ec2_ubuntu.public_ip
}
