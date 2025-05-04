provider "aws" {
    region = "us-east-1"
}


data "aws_ami" "ec2_ami" {
    most_recent = true
    owners = [ "amazon" ]
    filter {
      name = "name"
      values = [  "al2023-*"]
    }
  
}



resource "aws_instance" "app-dev" {

    ami = data.aws_ami.ec2_ami.id
    instance_type = "t2.micro"
 
}

