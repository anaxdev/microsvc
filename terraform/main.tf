module "vpc" {
  source = "./modules/vpc"

  environment = var.environment
  name_prefix = var.name_prefix
}

# Security Group
resource "aws_security_group" "app_sg" {
  description = "Allow SSH/HTTP inbound traffic"
  vpc_id      = module.vpc.id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "SSH from VPC"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "HTTP from VPC"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name        = "${var.name_prefix}_sg"
    environment = var.environment
  }
}

# AMI
data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

# Key_Pair
resource "aws_key_pair" "app_key_pair" {
  key_name   = "${var.name_prefix}_key"
  public_key = file(format("%s/%s", pathexpand("~/.ssh"), var.public_key_name))
}

# EC2 Instance
resource "aws_instance" "ec2_ubuntu" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t2.micro"

  # VPC
  subnet_id = module.vpc.subnet

  # Security Group
  vpc_security_group_ids = ["${aws_security_group.app_sg.id}"]

  # Register Public SSH key
  key_name = aws_key_pair.app_key_pair.key_name

  tags = {
    Name        = "${var.ec2_instance_name}"
    environment = var.environment
  }
}
