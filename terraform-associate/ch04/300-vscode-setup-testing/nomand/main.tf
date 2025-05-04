provider "aws" {

    region = "us-east-1"
  
}

variable "var1" {
    type = string
    description = "variable 1"
    nullable = false

  
}

output "random" {
  value = "random"
}