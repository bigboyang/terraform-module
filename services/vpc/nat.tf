
#EIP
resource "aws_eip" "nat" {
  vpc = true
}

# Nat gateway
resource "aws_nat_gateway" "nat_gw" {
  allocation_id = aws_eip.nat.id
  /* subnet_id     = aws_subnet.publicSubnet1.id */
  subnet_id     = aws_subnet.publicSubnet1.id

  depends_on = [aws_internet_gateway.IGW]
}

#EIP
resource "aws_eip" "nat2" {
  vpc = true
}

# Nat gateway
resource "aws_nat_gateway" "nat_gw2" {
  allocation_id = aws_eip.nat2.id
  /* subnet_id     = aws_subnet.publicSubnet2.id */
  subnet_id     = aws_subnet.publicSubnet2.id

  depends_on = [aws_internet_gateway.IGW]
}

