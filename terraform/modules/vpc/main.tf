### Network

# VPC
resource "aws_vpc" "app_vpc" {
  cidr_block = var.vpc_cidr_block

  tags = {
    Name        = "${var.name_prefix}_vpc"
    environment = var.environment
  }
}

# Subnet
resource "aws_subnet" "app_subnet" {
  vpc_id                  = aws_vpc.app_vpc.id
  cidr_block              = var.subnet_cidr_block
  map_public_ip_on_launch = true

  tags = {
    Name        = "${var.name_prefix}_subnet"
    environment = var.environment
  }
}

# Internet Gateway
resource "aws_internet_gateway" "app_igw" {
  vpc_id = aws_vpc.app_vpc.id

  tags = {
    Name        = "${var.name_prefix}_igw"
    environment = var.environment
  }
}

# Route table
resource "aws_route_table" "app_rt" {
  vpc_id = aws_vpc.app_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.app_igw.id
  }

  tags = {
    Name        = "${var.name_prefix}_rt"
    environment = var.environment
  }
}

# Route table associations
resource "aws_route_table_association" "app_rta" {
  subnet_id      = aws_subnet.app_subnet.id
  route_table_id = aws_route_table.app_rt.id
}
