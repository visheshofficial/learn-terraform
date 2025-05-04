provider "aws" {
    region = "us-east-1"
}


resource "aws_iam_user" "user1" {
  name  = "function-test-user"
  
}

data "local_file" "text_file" {
  filename = "${path.module}/demo.txt"
}


data  "aws_region" "current" {}

output "current_region" {
  value = data.aws_region.current.endpoint
}

data "aws_instances" "vms" {
  
}

output "vms" {
  value = data.aws_instances.vms[*].id
}

output "local_text" {
  value = data.local_file.text_file.content
}

data "aws_ami" "ec2_ami" {
    most_recent = true
    owners = [ "amazon" ]
    filter {
      name = "name"
      values = [  "al2023-*"]
    }
  
}

output "ec2_ami" {
  value = data.aws_ami.ec2_ami.name
}

resource "aws_iam_user_policy" "policy1" {

    name = "function-test-policy"
    user = aws_iam_user.user1.name
    policy = file("./policy.json")
  
}
locals {
  region = "us-east-1"
}

locals {
  owner = "admin"
}

variable "tags" {
    default = ["firstec2"]
  
}

variable "ami" {
    type = map
    default = {
        "us-east-1" = "ami-0f88e80871fd81e91"
    }
}

resource "aws_instance" "app-dev" {

    ami = lookup(var.ami,local.region)
    instance_type = "t2.micro"
    count = length(var.tags)
    tags = {
      Name= element(var.tags,count.index)
      CreationDate = formatdate("DD MMM YYYY hh:mm ZZZ ",timestamp())
    }
  
}

