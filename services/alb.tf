

# alb.tf
/* resource "aws_alb" "test" {
  name                             = "${var.cluster_name}-test-alb"
  internal                         = false
  load_balancer_type               = "application"
  security_groups                  = [data.terraform_remote_state.vpc.outputs.public_web_sg]
  subnets                          = [data.terraform_remote_state.vpc.outputs.public_subnet_id_1, data.terraform_remote_state.vpc.outputs.public_subnet_id_2]
  enable_cross_zone_load_balancing = true
} */

# asg에서 트레픽을 보낼 인스턴스 대상 그룹
# 인스턴스 대상그룹에게 alb에서 8080포트로 트레픽을 보냅니다.
resource "aws_alb_target_group" "test" {
  name     = "alb-target-${var.environment}"
  port     = 8080
  protocol = "HTTP"
  vpc_id   = data.terraform_remote_state.vpc.outputs.vpc_id

  health_check {
    interval            = 30
    path                = "/"
    port                = 8080
    healthy_threshold   = 3
    unhealthy_threshold = 3
  }
}

# alb의 리스너 rule
resource "aws_alb_listener_rule" "asg" {
  listener_arn = module.alb.alb_http_listener_arn
  priority          = 100
  
  condition {
    path_pattern{
      values = ["/"]
    }
  }
  action {
    type             = "forward"
    target_group_arn = aws_alb_target_group.test.arn
  }
}
