

provider "aws" {
  region = "us-east-1"
}


resource "aws_instance" "ec2_for_sg_check" {

  instance_type   = "t2.micro"
  ami             = "ami-0f88e80871fd81e91"
  vpc_security_group_ids = [aws_security_group.allow_http.id]
  tags ={
    "Name" = "ch04"
  }

}


resource "aws_security_group" "allow_http" {
  name        = "terraform-firewall"
  description = "Allow HTTP inbound traffic and all outbound traffic"
  tags = {
    Name = "terraform-firewall"
  }
}

resource "aws_vpc_security_group_ingress_rule" "allow_http" {

  security_group_id = aws_security_group.allow_http.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 80
  ip_protocol       = "tcp"
  to_port           = 80
}

resource "aws_vpc_security_group_egress_rule" "allow_all_traffic_ipv4" {
  security_group_id = aws_security_group.allow_http.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1" # semantically equivalent to all ports
}

output instance_id {
  value       = aws_instance.ec2_for_sg_check.id
}

output sg_id {
  value       = aws_security_group.allow_http.id
}