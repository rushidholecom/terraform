resource "aws_autoscaling_group" "home_auto_sacling" {
  name = "${var.project}-${var.env}-home-asg"
  availability_zones = ["ap-southeast-1a", "ap-southeast-1b"]
  desired_capacity = 1
  min_size = 1
  max_size = 2
  launch_template {
    id = aws_launch_template.home_launch_template.id
  }
}

resource "aws_autoscaling_policy" "home_policy" {
  name = "${var.project}-${var.env}-home-asg-policy"
  autoscaling_group_name = aws_autoscaling_group.home_auto_sacling.name
  policy_type = "TargetTrackingScaling"
  target_tracking_configuration {
    target_value = 60
    predefined_metric_specification {
       predefined_metric_type = "ASGAverageCPUUtilization"
    }
  }
}

resource "aws_autoscaling_group" "mobile_auto_sacling" {
  name = "${var.project}-${var.env}-mobile-asg"
  availability_zones = ["ap-southeast-1a", "ap-southeast-1a"]
  desired_capacity = 1
  min_size = 1
  max_size = 2
  launch_template {
    id = aws_launch_template.mobile_launch_template.id
  }
}

resource "aws_autoscaling_policy" "mobile_policy" {
  name = "${var.project}-${var.env}-home-asg-policy"
  autoscaling_group_name = aws_autoscaling_group.mobile_auto_sacling.name
  policy_type = "TargetTrackingScaling"
  target_tracking_configuration {
    target_value = 60
    predefined_metric_specification {
       predefined_metric_type = "ASGAverageCPUUtilization"
    }
  }
}

resource "aws_autoscaling_group" "laptop_auto_sacling" {
  name = "${var.project}-${var.env}-laptop-asg"
  availability_zones = ["ap-southeast-1a", "ap-southeast-1a"]
  desired_capacity = 1
  min_size = 1
  max_size = 2
  launch_template {
    id = aws_launch_template.laptop_launch_template.id
  }
}

resource "aws_autoscaling_policy" "laptop_policy" {
  name = "${var.project}-${var.env}-home-asg-policy"
  autoscaling_group_name = aws_autoscaling_group.laptop_auto_sacling.name
  policy_type = "TargetTrackingScaling"
  target_tracking_configuration {
    target_value = 60
    predefined_metric_specification {
       predefined_metric_type = "ASGAverageCPUUtilization"
    }
  }
}

resource "aws_autoscaling_attachment" "home_tg_attachment" {
  autoscaling_group_name = aws_autoscaling_group.home_auto_sacling.name
  lb_target_group_arn = aws_lb_target_group.home_target_group.arn
}

resource "aws_autoscaling_attachment" "mobile_tg_attachment" {
  autoscaling_group_name = aws_autoscaling_group.mobile_auto_sacling.name
  lb_target_group_arn = aws_lb_target_group.mobile_target_group.arn
  depends_on = [ aws_autoscaling_attachment.home_tg_attachment ]
}

resource "aws_autoscaling_attachment" "laptop_tg_attachment" {
  autoscaling_group_name = aws_autoscaling_group.laptop_auto_sacling.name
  lb_target_group_arn = aws_lb_target_group.laptop_target_group.arn
  depends_on = [ aws_autoscaling_attachment.mobile_tg_attachment ]
}