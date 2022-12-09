data "terraform_remote_state" "vpc" {
  backend = "s3"

  config = {
    bucket = "kkc-terraform-state"
    key    = "state/services/vpc/terraform-tfstate"
    region = "ap-northeast-2"
  }
}

# subnet_group
resource "aws_db_subnet_group" "db-subnet-group" {
  name = "test"
  subnet_ids = [
    data.terraform_remote_state.vpc.outputs.private_subnet_id_1, 
    data.terraform_remote_state.vpc.outputs.private_subnet_id_2
  ]
  tags = {
    "Name" = "db-subnet-group"
  }
}

resource "aws_db_instance" "example" {
    identifier_prefix       = "db-"
    engine                  = "mysql"
    allocated_storage       = 10 #10G의 스토리지 할당
    instance_class          = "db.t2.micro"
    db_name                 = "mysql_database"
    username                = "admin"
    skip_final_snapshot     = true # db삭제시 최종 스냅샷을 생성하지 않음

    vpc_security_group_ids = [data.terraform_remote_state.vpc.outputs.private_mysql_sg]
    db_subnet_group_name   = aws_db_subnet_group.db-subnet-group.name # 끌고와야함

    password                = var.db_password

}