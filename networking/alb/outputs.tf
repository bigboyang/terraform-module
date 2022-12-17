output "alb_dns_name" {
    value       = aws_alb.test.name
    description = "alb_dns_name"
}

output "alb_http_listener_arn" {
    value       = aws_alb_listener.test.arn
    description = "alb_http_listener_arn"
}

output "alb_security_group_id" {
    value       = data.terraform_remote_state.vpc.outputs.public_web_sg
    description = "alb_security_group_id"
}

output "alb_target_group_arn" {
    value       = aws_alb_target_group.test.arn
    description = "alb_target_group_arn"
}
