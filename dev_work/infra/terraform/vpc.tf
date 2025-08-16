# VPC
resource "aws_vpc" "dev_vpc" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support   = true
  tags = {
    Name = "dev-vpc"
  }
}
# Subnet
resource "aws_subnet" "dev_subnet" {
  vpc_id                  = aws_vpc.dev_vpc.id
  cidr_block              = "10.0.1.0/24"
  map_public_ip_on_launch = true
  availability_zone       = "ap-south-1a"
  tags = {
    Name = "Dev-PublicSubnet"
  }
}

# Create Public Subnet in ap-south-1b
resource "aws_subnet" "public_b" {
  vpc_id                  = aws_vpc.dev_vpc.id
  cidr_block              = "10.0.2.0/24"
  availability_zone       = "ap-south-1b"
  map_public_ip_on_launch = true
  tags = { Name = "public-subnet-b" }
}

# Internet Gateway
resource "aws_internet_gateway" "dev_igtw" {
  vpc_id = aws_vpc.dev_vpc.id
  tags = {
    Name = "dev-igtw"
  }
}

# Route Table
resource "aws_route_table" "dev_route_table" {
  vpc_id = aws_vpc.dev_vpc.id
  tags = {
    Name = "dev_prt"
  }
}

# Route for Internet Access
resource "aws_route" "dev_route" {
  route_table_id         = aws_route_table.dev_route_table.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.dev_igtw.id
}

# Associate Route Table with Subnet
resource "aws_route_table_association" "dev_route_assoc" {
  subnet_id      = aws_subnet.dev_subnet.id
  route_table_id = aws_route_table.dev_route_table.id
}

# Security Group
resource "aws_security_group" "dev_sg" {
  name        = "dev_sec_gp"
  description = "Allow SSH and HTTP"
  vpc_id      = aws_vpc.dev_vpc.id

  ingress {
    description = "Allow SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Allow HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "dev_sec_gp"
  }
}
