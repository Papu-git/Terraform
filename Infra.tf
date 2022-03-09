provider "aws" {
  region     = "ap-south-1"
}
resource "aws_instance" "wipro-web" {
  ami           = var.ami
  instance_type = var.instance_type
  key_name = var.key_name
  vpc_security_group_ids = [aws_security_group.wipro-sg.id]
  subnet_id = aws_subnet.wipro-publicsubnet.id

  tags = {
    Name = "WebServer"
  }
}
resource "aws_vpc" "wipro-vpc" {
  cidr_block       = "10.0.0.0/16"
  instance_tenancy = "default"

  tags = {
    Name = "wipro-vpc"
  }
}
resource "aws_subnet" "wipro-publicsubnet" {
  vpc_id     = aws_vpc.wipro-vpc.id
  cidr_block = "10.0.1.0/24"

  tags = {
    Name = "wipro-publicsubnet"
  }
}
resource "aws_internet_gateway" "wipro-igw" {
  vpc_id = aws_vpc.wipro-vpc.id

  tags = {
    Name = "wipro-igw"
  }
}
resource "aws_route_table" "wipro-rt-public" {
  vpc_id = aws_vpc.wipro-vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.wipro-igw.id
  }
  tags = {
    Name = "wipro-rt"
  }
}
resource "aws_route_table_association" "wipro-public-asso" {
  subnet_id      = aws_subnet.wipro-publicsubnet.id
  route_table_id = aws_route_table.wipro-rt-public.id
}
resource "aws_security_group" "wipro-sg" {
  name        = "wipro-sg"
  description = "Allow TLS inbound traffic"
  vpc_id      = aws_vpc.wipro-vpc.id

  ingress {
    description      = "TLS from VPC"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }
  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  tags = {
    Name = "wipro-sg"
  }
}
resource "aws_key_pair" "wipro-key" {
  key_name   = var.key_name
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQC+Y1/R0Ao5wnl/3R915kZOk6efi+iECyBAG8htGiwd5HxcEG/4zPR8XBRVzKIk3sZYOLZIs8qChtUGDBMVcjq4RaA4o04gZtazFQ6ZEKQg645XmH/rErXycHhH0bEJFY5Gwr9c5a6UkkUvM0Xj5gF0IwEaPuhMYm95RqTNOa5b9hAv3sNXFwkl4nj1ksg5vGMqnrvEKq1arprZLJFfT5hqTqRmYYD4V+j5KxMWb4+wo75HOOV+fBNRAcRV6V4sTk1vHW6kzwNfc1Z4KgTGMKOuApYZjkAZdlykUSPnfCrA+L8TqZWggDn5OikQh1X9XPEZsy7um/p0Ky0p2a5KGqwGlugP9AtctQTYNjfP1bvtpy4VFzlOgBhA1kQzDUXnoCCynUypIltv+SRvWzM1wLBEcgf59McaYtI1z8ENzgAZao3V49OFNPTMU9V5dBowDNZyUtXDDt/79LUPYbOnm/m0PDsDB4MyaTvDrJrdsW31FmTYe0qKghtt0wNwQJoiH/c= administrator@DESKTOP-RLA0UNQ"
}
resource "aws_eip" "lb" {
  instance = aws_instance.wipro-web.id
  vpc      = true
}
