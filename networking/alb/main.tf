# alb.tf
resource "aws_alb" "test" {
  name                             = "${var.cluster_name}-${var.alb_name}"
  internal                         = false
  load_balancer_type               = "application"
  security_groups                  = [local.public_web_sg]
  subnets                          = [local.public_subnet_id_1, local.public_subnet_id_2]
  enable_cross_zone_load_balancing = true
}

# asg에서 트레픽을 보낼 인스턴스 대상 그룹
# 인스턴스 대상그룹에게 alb에서 8080포트로 트레픽을 보냅니다.
/* resource "aws_alb_target_group" "test" {
  name     = "alb-target"
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
} */

# alb의 리스너
resource "aws_alb_listener" "test" {
  load_balancer_arn = aws_alb.test.arn
  port              = 80
  protocol          = "HTTP"

  /* default_action {
    type             = "forward"
    target_group_arn = var.target_group_arns
  } */

  default_action {
    type    = "fixed-response"

    fixed_response {
      content_type = "text/plain"
      message_body  = "404: page not found"
      status_code = 404
    }
  }
}

data "aws_route53_zone" "selected" {
  name         = "rocknrollloveaffair.com"
}

resource "aws_route53_record" "www" {
  zone_id        =  data.aws_route53_zone.selected.zone_id
  name           = "*.rocknrollloveaffairAAA.com" 
  type           = "A"

  alias {
    name                   = aws_alb.test.dns_name
    zone_id                = aws_alb.test.zone_id
    evaluate_target_health = true
  }
}
