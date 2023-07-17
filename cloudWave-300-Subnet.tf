
# CloudWave Public 서브넷 생성
resource "aws_subnet" "subnet-cwave-public" {
  count      = length(var.subnet-cidrs-cwave-public)
  vpc_id     = aws_vpc.cwave-vpc.id
  cidr_block = var.subnet-cidrs-cwave-public[count.index]
  availability_zone = var.availability-zones[count.index]
  map_public_ip_on_launch = true
tags = {
    Name = "SUBNET-${var.env-prefix}-PUBLIC-${var.subnet-cidrs-cwave-public[count.index]}"
    "kubernetes.io/cluster/${var.cwave-cluster-name}" = "shared"
    "kubernetes.io/role/elb"                      = "1"
  }
}


# CloudWave Private 서브넷 생성
resource "aws_subnet" "subnet-cwave-private" {
  count      = length(var.subnet-cidrs-cwave-private)
  vpc_id     = aws_vpc.cwave-vpc.id
  cidr_block = var.subnet-cidrs-cwave-private[count.index]
  availability_zone = var.availability-zones[count.index]
  tags = {
    Name = "SUBNET-${var.env-prefix}-PRIVATE-${var.subnet-cidrs-cwave-private[count.index]}"
    "kubernetes.io/cluster/${var.cwave-cluster-name}" = "shared"
    "kubernetes.io/role/internal-elb"             = "1"
  }
}