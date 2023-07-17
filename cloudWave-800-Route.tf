# Cwave Public Route Table 생성 및 연결
resource "aws_route_table" "cwave-public-route-table" {
  count  = length(var.subnet-cidrs-cwave-public)
  vpc_id = aws_vpc.cwave-vpc.id

  ## Route for Public Subnet to Internet Gateway 
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.cwave-igw.id
  }
  tags = {
    Name = "${var.env-prefix}-0${count.index + 1}-Public-Route"
  }
}

resource "aws_route_table_association" "cwave-public-route-table-asc" {
  count = length(var.availability-zones)
  subnet_id = element(aws_subnet.subnet-cwave-public.*.id, count.index)
  route_table_id = element(aws_route_table.cwave-public-route-table.*.id, count.index)
}

# Cwave Private Subnet Route Table 생성 및 연결
resource "aws_route_table" "cwave-private-route-table" {
  count  = length(var.subnet-cidrs-cwave-private)
  vpc_id = aws_vpc.cwave-vpc.id

  ## Route for Private to NAT 
  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = element(aws_nat_gateway.cwave-public-nat-gateway.*.id, count.index)
  }
  tags = {
    Name = "${var.env-prefix}-PRIVATE-To-NAT-${count.index + 1}-Route"
  }
}
resource "aws_route_table_association" "cwave-private-route-table-asso" {
  count = length(var.availability-zones)
  subnet_id = element(aws_subnet.subnet-cwave-private.*.id, count.index)
  route_table_id = element(aws_route_table.cwave-private-route-table.*.id, count.index)
}