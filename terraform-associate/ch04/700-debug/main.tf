provider "aws" {
    region = "us-east-1"
}

resource "local_file" "foo_txt" {
    content = "hello"
    filename = "${path.module}/foo.txt"
  
}

# TF_LOG
# TF_LOG_PATH