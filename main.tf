provider "aws" {
  region = "eu-north-1"  # Replace with your desired region
}

resource "aws_instance" "example" {
  ami           = "ami-09a9858973b288bdd" # Replace with your desired AMI ID
  instance_type = "t3.micro"              # Replace with your desired instance type

  tags = {
    Name = "ExampleInstance-arun"
  }
}

output "instance_public_ip" {
  value = aws_instance.example.public_ip
}
