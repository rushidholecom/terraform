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
  subnets = data.aws_subnets.subnet-1.ids
}

resource "aws_lb_listener" "lb_listener" {
  load_balancer_arn = aws_lb.lb.arn
  port = 80
  protocol = "HTTP"
  default_action {
    type = "forword"
    target_group_arn = aws_lb_target_group.home_target_group.arn
  }
}

resource "aws_lb_listener_rule" "mobile_listner_rule" {
  listener_arn = aws_lb_listener.lb_listener.arn
  priority = 100

  action {
    type = "forword"
    target_group_arn = aws_lb_target_group.mobile_target_group.arn
  }
  condition {
    path_pattern {
      values = ["/mobile/*"]
    }
  }
}

resource "aws_lb_listener_rule" "laptop_listerner_rule" {
  listener_arn = aws_lb_target_group.laptop_target_group.arn
  priority = 101
  action {
    type = "forword"
    target_group_arn = aws_lb_target_group.laptop_target_group.arn
  }
  condition {
    path_pattern {
      values = ["/laptop/*"]
    }
  }
}