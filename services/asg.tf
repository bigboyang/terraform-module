
# asg.tf
/* resource "aws_autoscaling_group" "asg-01" {
  name                      = "${var.cluster_name}-${aws_launch_configuration.ec2.name}" # 시작구성의 이름에 의존하도록 지정, 시작구성이 교체될때마다 ASG도 교채된다.
  min_size                  = var.min_size
  max_size                  = var.max_size
  health_check_grace_period = 500
  health_check_type         = "ELB"
  desired_capacity          = 2
  force_delete              = true
  target_group_arns         = [aws_alb_target_group.test.arn]
  launch_configuration      = aws_launch_configuration.ec2.name
  # asg에 대한 가용역역
  vpc_zone_identifier       = [data.terraform_remote_state.vpc.outputs.public_subnet_id_1, data.terraform_remote_state.vpc.outputs.public_subnet_id_2] # asg에 대한 가용역역

  min_elb_capacity          = var.min_size # ASG배포 완료를 고려하기전 최소 지정된 인스턴스가 상태확인을 통과할때까지 기다림

  lifecycle  {
    create_before_destroy = true
  }

  tag {
    key                   = "Name"
    value                 = var.cluster_name
    propagate_at_launch   = true
  }

  dynamic "tag" { # 여기서 tag는 for_each로 가져온 obj이자 module에서 inline요소를 추가할 인라인값?

    for_each  = {
      for key, value in var.custom_tags :
      key => upper(value)
      if key != "Name" # Name key을 필터링
    }

    content {
      key     = tag.key
      value   = tag.value
      propagate_at_launch   = true
    }
  }
} */

# asg스케줄러 
/* resource "aws_autoscaling_schedule" "sacle_out_during_business_hours" {
    count                       = var.enable_autoscaling ? 1 : 0

    scheduled_action_name       = "${var.cluster_name}-scale-out-during-biz-hours"
    min_size                    = 1
    max_size                    = 10
    desired_capacity            = 2
    recurrence                  = "0 9 * * *"
    autoscaling_group_name      = aws_autoscaling_group.asg-01.name
}
resource "aws_autoscaling_schedule" "sacle_in_during_night_hours" {
    count                       = var.enable_autoscaling ? 1 : 0

    scheduled_action_name       = "${var.cluster_name}-scale-out-during-night-hours"
    min_size                    = 1
    max_size                    = 2
    desired_capacity            = 1
    recurrence                  = "0 17 * * *"
    autoscaling_group_name      = aws_autoscaling_group.asg-01.name
} */

/* data "aws_ami" "ubuntu" {
  most_recent = true
  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }
  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
  owners = ["099720109477"]
} */

# db정보를 변환하는 탬플릿 생성 (1번)
data "template_file" "user_data" {

  template = file("${path.module}/user-data.sh")

  # 템플릿에 넘길 변수 선언
  vars = {
    db_address = data.terraform_remote_state.db.outputs.address
    db_port    = data.terraform_remote_state.db.outputs.port
    server_text = var.server_text
  }
}

 /* resource "aws_launch_configuration" "ec2" {

  image_id      = data.aws_ami.ubuntu.image_id
  instance_type = "t2.micro"
  key_name      = "keykey"

  security_groups             = [data.terraform_remote_state.vpc.outputs.public_web_sg]
  associate_public_ip_address = true

  user_data = data.template_file.user_data.rendered

  lifecycle {
    create_before_destroy = true
  }
}
 */

 


