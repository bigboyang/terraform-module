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

