data "aws_subnets" "subnet-1" {
    filter {
      name = "vpc-id"
      values = [data.aws_vpc.default.id]
    }

}


resource "aws_lb" "lb" {
  name = "${var.project}-${var.env}-lb"
  load_balancer_type = "application"
  security_groups = [aws_security_group.security_group.id]
  internal = false
  subnets = data.aws_subnets.subnet-1
}