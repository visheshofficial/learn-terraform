provider "aws" {
    region = "us-east-1"
}
locals {
  ports = [8200,9200,9300,9400]
}
resource "aws_security_group" "dynamic-sg" {
    name = "dynamic-sg"
  dynamic "ingress" {
    for_each = local.ports 
    iterator = port
    content {
      to_port = port.value
      from_port = port.value
      protocol = "tcp"
      cidr_blocks = [  "0.0.0.0/0"]
    }
  }
}


# resource "aws_vpc_security_group_ingress_rule" "dynamic-ingress" {
#     security_group_id = aws_security_group.dynamic-sg.id
#     ip_protocol = "tcp"
#     from_port = 80
#     to_port = 80
#     cidr_ipv4 = "0.0.0.0/0"
  
# }