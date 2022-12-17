# CPU사용률 경보 - 5분 동안 90% 이상일떄
resource "aws_cloudwatch_metric_alarm" "high_cpu_utilization" {
    alarm_name          ="${var.cluster_name}-high_cpu_utilization"
    namespace           ="AWS/EC2"
    metric_name         ="CPUUtilization"

    dimensions          ={
        AutoSaclingGroupName = aws_autoscaling_group.asg-01.name
    }

    comparison_operator ="GreaterThanThreshold"
    evaluation_periods  = 1
    period              = 300
    statistic           = "Average"
    threshold           = 90
    unit                = "Percent"
}

# cpu 크레딧 관련 경보
resource "aws_cloudwatch_metric_alarm" "low_cpu_credit_balance" {

    count               =format("%.1s", var.instance_type == "t" ? 1 : 0)

    alarm_name          ="${var.cluster_name}-low_cpu_credit_balance"
    namespace           ="AWS/EC2"
    metric_name         ="CPUUtilization"

    dimensions          ={
        AutoSaclingGroupName = aws_autoscaling_group.asg-01.name
    }

    comparison_operator ="LessThanThreshold"
    evaluation_periods  = 1
    period              = 300
    statistic           = "Minimum"
    threshold           = 10
    unit                = "Count"
}