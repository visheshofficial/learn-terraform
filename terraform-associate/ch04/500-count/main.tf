provider "aws" {
  region = "us-east-1"
}


variable "environment" {
  type = string


}

variable "region" {
  type = string


}
resource "aws_instance" "vm-set" {
  ami           = "ami-0f88e80871fd81e91"
  instance_type = var.environment == "dev" && var.region =="us-east-1" ? "t2.micro" : "t2.medium"
  count         = 1
  tags = {
    "Name" = "vm-${count.index}"
  }



}

variable "user_names" {
  default = ["alice", "bob", "jack"]
  type    = list(string)

}

resource "aws_iam_user" "users" {
  count = length(var.user_names)
  name  = var.user_names[count.index]
}

