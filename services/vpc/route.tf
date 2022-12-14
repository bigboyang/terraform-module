
# public라우트테이블
resource "aws_route_table" "testPublicRTb" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.IGW.id
  }

  tags = {
    "Name" = "test-public-rtb"
  }
}

## route subnet associate
resource "aws_route_table_association" "publicAssociation01" {
  subnet_id      = aws_subnet.publicSubnet1.id
  route_table_id = aws_route_table.testPublicRTb.id
}

resource "aws_route_table_association" "privateAssociation01" {
  subnet_id      = aws_subnet.privateSubnet1.id
  route_table_id = aws_route_table.testPrivateRTb.id
}


#private라우트테이블
resource "aws_route_table" "testPrivateRTb" {
  vpc_id = aws_vpc.vpc.id
  
  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat_gw.id
  }

  tags = {
    "Name" = "test-private-rtb"
  }
}

resource "aws_route_table_association" "publicAssociation02" {
  subnet_id      = aws_subnet.publicSubnet2.id
  route_table_id = aws_route_table.testPublicRTb.id
}

resource "aws_route_table_association" "privateAssociation02" {
  subnet_id      = aws_subnet.privateSubnet2.id
  route_table_id = aws_route_table.testPrivateRTb.id
}
