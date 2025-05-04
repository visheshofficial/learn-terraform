terraform {
  required_providers {
    random ={
      source = "hashicorp/random"
    }
    aws = {
      source = "hashicorp/aws"
    }
    google = {
      source = "hashicorp/google"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}

resource "random_pet" "random_pet" {

  prefix = "cute"
}

output "random_per_name" {
  value = random_pet.random_pet.id
  description = "random per name"
  
}
resource "aws_instance" "ec2" {
  ami = "ami-0f88e80871fd81e91"
  instance_type = "t2.micro"

}

output "ec2" {
  value = aws_instance.ec2.arn
}


module "vpc"{
  source = "./nomand"
  var1 = "123"
  

}
output "random_nomad" {
  value = module.vpc.random
}