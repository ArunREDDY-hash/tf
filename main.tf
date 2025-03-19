provider "aws" {
  region = "us-east-1"  # Replace with your desired region
}

resource "aws_instance" "example" {
count         = 3  # This will create 3 instances
  ami           = "ami-04b4f1a9cf54c11d0" # Replace with your desired AMI ID
  instance_type = "t2.micro"              # Replace with your desired instance type

  tags = {
    Name = "ExampleInstance-arun${count.index + 1}"
  }
}

output "instance_public_ip" {
  value =[for inst in aws_instance.example : inst.public_ip]
}
