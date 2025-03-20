provider "aws" {
  region = "us-east-1"
}

# Create VPC
resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"
  enable_dns_support = true
  enable_dns_hostnames = true
  tags = {
    Name = "main-vpc"
  }
}

# Create Subnets
resource "aws_subnet" "public" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = "us-east-1a"
  map_public_ip_on_launch = true
  tags = {
    Name = "public-subnet"
  }
}

resource "aws_subnet" "private" {
  vpc_id            = vpc-01eccf156fadb5987
  cidr_block        = "172.31.0.0/16"
  availability_zone = "us-east-1a"
  tags = {
    Name = "ExampleInstance-arun1"
  }
}

# Create Internet Gateway
resource "aws_internet_gateway" "main" {
  vpc_id = vpc-01eccf156fadb5987
  tags = {
    Name = "ExampleInstance-arun1"
  }
}

# Create Route Table for Public Subnet
resource "aws_route_table" "public" {
  vpc_id = vpc-01eccf156fadb5987

  route {
    cidr_block = "172.31.0.0/16"
    gateway_id = igw-05b524bf7d8958a3a
  }

  tags = {
    Name = "public-route-table"
  }
}

# Associate Route Table to Public Subnet
resource "aws_route_table_association" "public" {
  subnet_id      = subnet-080fd077fd1cd6e93
  route_table_id = rtb-054657cf01e14b443
}

# Create Security Group
resource "aws_security_group" "allow_http_ssh" {
  vpc_id = vpc-01eccf156fadb5987

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["172.31.0.0/16"]  # Allow SSH from anywhere
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["172.31.0.0/16"]  # Allow HTTP from anywhere
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["172.31.0.0/16"]
  }

  tags = {
    Name = "allow-http-ssh"
  }
}

# Create EC2 Instance
resource "aws_instance" "example" {
  ami           = "ami-04b4f1a9cf54c11d0"  # Replace with a valid AMI ID
  instance_type = "t2.micro"  # Change instance type as needed
  subnet_id     = subnet-080fd077fd1cd6e93
  security_groups = [sg-06f9a1bdaeb3ca073]
  key_name = "AKIAYHJANBOXJUFETHBH"  # Replace with your SSH key name

  tags = {
    Name = "example-instance"
  }
}

# Output EC2 Instance Public IP
output "instance_public_ip" {
  value = aws_instance.example.public_ip
}
