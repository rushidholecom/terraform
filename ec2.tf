provider "aws" {
    region = "eu-west-2"
}

resource "aws_instance" "terraform-prac" {
  ami = "ami-075f150fc1ca69e71"
  instance_type = "t3.micro"
  key_name = "rr-london"
  vpc_security_group_ids = ["sg-0afd97e579140952f"]
  tags = {
    Name = "terraform-prac"
    env = "dev"
  }
}