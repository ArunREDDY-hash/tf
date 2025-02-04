provider "aws" {
  region = "us-west-2"  # Replace with your desired region
}

resource "aws_instance" "example" {
  ami           = "ami-0a897ba00eaed7398" # Replace with your desired AMI ID
  instance_type = "t2.micro"              # Replace with your desired instance type

  tags = {
    Name = "ExampleInstance-arun"
  }
}

output "instance_public_ip" {
  value = aws_instance.example.public_ip
}
