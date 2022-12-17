data "terraform_remote_state" "vpc" {
  backend = "s3"

  config = {
    bucket = "kkc-terraform-state"
    key    = "state/services/vpc/terraform-tfstate"
    region = "ap-northeast-2"
  }
}

# s3에서 db 정보 가져옴, 모두 읽기 전용임
data "terraform_remote_state" "db" {
  backend = "s3"

  config = {
    bucket = "kkc-terraform-state"
    /* bucket  = var.db_remote_state_bucket */
    key     = var.db_remote_state_key 
    /* key    = "state/data-stores/mysql/terraform.tfstate" */
    
    region = "ap-northeast-2"

  }
}

module "asg" {
    source      = "../../modules/cluster/asg-rolling-deploy"
    
    cluster_name                = "stage-${var.environment}"
    user_data                   = data.template_file.user_data.rendered
    subnet_ids                  = [data.terraform_remote_state.vpc.outputs.public_subnet_id_1, data.terraform_remote_state.vpc.outputs.public_subnet_id_2] 
    target_group_arns           = aws_alb_target_group.test.arn

    enable_autoscaling          = true
    server_text                 = "Bye World!"
    min_size                    = 2
    max_size                    = 6

    custom_tags = {
        Owners          = "team-kkc"
        DevelopedBy     = "terraform"
    }
}

module "alb" {
    source      = "../../modules/networking/alb"
    
    target_group_arns           = aws_alb_target_group.test.arn
    cluster_name                = "stage-${var.environment}"
    alb_name                    = "hello-world-${var.environment}"

}

