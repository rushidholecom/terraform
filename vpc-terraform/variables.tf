variable project {
  default = "cbz"
}

variable vpc_cidr {
  default = "10.10.0.0/20"
}

variable "public_subnet_cidr" {
  default = "10.10.0.0/22"   
}

variable "private_subnet_cidr" {
  default = "10.10.1.0/22"
}

variable "public_az" {
  default = "ap-southeast-1a"
}

variable "private_az" {
  default = "ap-southeast-1b"
}