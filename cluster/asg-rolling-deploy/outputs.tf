output "asg_name" {
    value       = aws_autoscaling_group.asg-01.name
    description = "asg_name"
}

output "instance_security_group_id" {
    value       = data.terraform_remote_state.vpc.outputs.public_web_sg
    description = "instance_security_group_id"
}