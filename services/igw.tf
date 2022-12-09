# igw.tf
resource "aws_internet_gateway" "IGW" {
  /* vpc_id = aws_vpc.vpc.id */
  vpc_id    = data.terraform_remote_state.vpc.outputs.vpc_id
  tags = {
    "Name" = "IGW"
  }
}
