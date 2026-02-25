provider "aws" {
  region = "ap-southeast-"
}

resource "aws_launch_template" "home_launch_template" {
  image_id = var.image_id
  instance_type = var.instance_type
  name = "${var.project}-${var.env}-home-lt"
  key_name = "rr-rushi-singapore"
  tags = {
    env = var.env
  }

  vpc_security_group_ids =  [aws_security_group.security_group.id]
  user_data = base64dencode(<<-EOF
  #!/bin/bash
  apt update -y
  apt install apache2 -y
  systemctl start apache2
  systemctl enable apache2
  echo "<h1> HELLO WORLD </h1>" > /var/www/html/index.html
  EOF
  )
}

resource "aws_launch_template" "mobile_launch_template" {
  image_id = var.image_id
  instance_type = var.instance_type
  name = "${var.project}-${var.env}-mobile-lt"
  key_name = "rr-rushi-singapore"
  tags = {
    env = var.env
  }

  vpc_security_group_ids = [aws_security_group.security_group.id]
  user_data = base64dencode(<<-EOF
  #!/bin/bash
  apt update -y
  apt install apache2 -y
  systemctl start apache2
  systemctl enable apache2
  echo "<h1> This is mobile page </h1>" > /var/www/html/mobile/index.html
  EOF
  )
}

resource "aws_launch_template" "laptop_launch_template" {
  image_id = var.image_id
  instance_type = var.instance_type
  name = "${var.project}-${var.env}-laptop-lt"
  key_name = "rr-rushi-singapore"
  tags = {
    env = var.env
  }

  vpc_security_group_ids = [aws_security_group.security_group.id]
  user_data = base64dencode(<<-EOF
  #!/bin/bash
  apt update -y
  apt install apache2 -y
  systemctl start apache2
  systemctl enable apache2
  echo "<h1> This is laptop page </h1>" > /var/www/html/laptop/index.html
  EOF
  )
}