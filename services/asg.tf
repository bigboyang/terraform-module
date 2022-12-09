
# asg.tf
resource "aws_autoscaling_group" "asg-01" {
  name                      = "asg-test"
  min_size                  = 2
  max_size                  = 6
  health_check_grace_period = 500
  health_check_type         = "ELB"
  desired_capacity          = 2
  force_delete              = true
  target_group_arns         = [aws_alb_target_group.test.arn]
  launch_configuration      = aws_launch_configuration.ec2.name
  /* vpc_zone_identifier       = [aws_subnet.publicSubnet1.id, aws_subnet.publicSubnet2.id] # asg에 대한 가용역역 */
  vpc_zone_identifier       = [data.terraform_remote_state.vpc.outputs.public_subnet_id_1, data.terraform_remote_state.vpc.outputs.public_subnet_id_2] # asg에 대한 가용역역
}

data "aws_ami" "ubuntu" {
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
}

# db정보를 변환하는 탬플릿 생성
data "template_file" "user_data" {
  template = file("${path.module}/user-data.sh")

  # 템플릿에 넘길 변수 선언
  vars = {
    db_address = data.terraform_remote_state.db.outputs.address
    db_port    = data.terraform_remote_state.db.outputs.port
  }
}

resource "aws_launch_configuration" "ec2" {

  image_id      = data.aws_ami.ubuntu.image_id
  instance_type = "t2.micro"
  key_name      = "keykey"

  /* security_groups             = [aws_security_group.publicSG01.id] */
  security_groups             = [data.terraform_remote_state.vpc.outputs.public_web_sg]
  associate_public_ip_address = true

  user_data = data.template_file.user_data.rendered

  lifecycle {
    create_before_destroy = true
  }
}





