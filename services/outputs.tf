output "asg_name" {
    value               = module.asg.asg_name
    description         = "asg-name"
}

output "alb_dns_name" {
    value               = module.alb.alb_dns_name
    description         = "alb-name"
}