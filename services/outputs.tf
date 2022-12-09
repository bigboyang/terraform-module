output "asg_name" {
    value               = aws_autoscaling_group.asg-01.name
    description         = "asg-name"
}

output "alb_dns_name" {
    value               = aws_alb.test.name
    description         = "alb-name"
}