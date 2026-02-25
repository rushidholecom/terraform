provider "aws" {
  region = "ap-southeast-1"
}

resource "aws_vpc" "easycrud-vpc" {
  tags = {
    name = "${var.project}-vpc"
  }  
  cidr_block = var.vpc_cidr
}

resource "aws_subnet" "public"{
    vpc_id = "${aws_vpc.easycrud-vpc.id}"
    cidr_block = var.public_subnet_cidr
    map_public_ip_on_launch = true
    availability_zone = var.public_az   
}

resource "aws_subnet" "private"{
    vpc_id = "${aws_vpc.easycrud-vpc.id}"
    cidr_block = var.private_subnet_cidr
    map_public_ip_on_launch = false
    availability_zone = var.private_az 
}
