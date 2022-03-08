provider "aws" {
  region     = "ap-south-1"
  access_key = "AKIA57AAH6I5GUI3V2NR"
  secret_key = "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"
}
resource "aws_instance" "Tata-web" {
  ami           = "ami-0c6615d1e95c98aca"
  instance_type = "t2.micro"
  tags = {
    Name = "Tata-web"
  }
}
