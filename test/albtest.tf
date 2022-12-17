provider "aws" {
    region      = "ap-northeast-2"
}

module "alb" {
    source = "../networking/alb/"

    cluster_name = "test"
    alb_name = "module-test"
}