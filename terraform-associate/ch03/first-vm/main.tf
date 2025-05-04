
provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "test" {
  ami           = "ami-0f88e80871fd81e91"
  instance_type = "t2.micro"
  tags = {
    "Name" : "Terraform-Associate-01"
  }
}

output "test_instance_name" {
  value = aws_instance.test.tags.Name
}