terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
    }
  }
}

## Provider configurations

provider "aws" {
  region = "us-east-1"
}

## Variables
variable "https_port" {
  default = 443
  type = number
  description = "HTTPS Port number"
  
}

## Resources
resource "aws_instance" "ec2" {
  ami           = "ami-0f88e80871fd81e91"
  instance_type = "t2.micro"

}

resource "aws_security_group" "firewall" {
  name = "firewall-sg"

}


resource "aws_vpc_security_group_ingress_rule" "firewall-ingress" {
  from_port         = var.https_port
  to_port           = var.https_port
  ip_protocol       = "tcp"
  security_group_id = aws_security_group.firewall.id
  cidr_ipv4         = "${aws_eip.eip.public_ip}/32"
  depends_on        = [aws_eip.eip]

}

resource "aws_eip" "eip" {
  instance = aws_instance.ec2.id
}


## Outputs

output "ec2" {
  value = aws_instance.ec2.arn
}

output "eip" {
  value = "https://${aws_eip.eip.public_ip}"
}


