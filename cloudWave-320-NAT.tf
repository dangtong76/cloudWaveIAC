# CloudWave VPC의 Public 서브넷에 NAT 생성
# resource "aws_eip" "cwave-public-nat-eip" {
#   count = length(var.subnet-cidrs-cwave-public)
#   vpc = true
#   lifecycle {
#     create_before_destroy = true
#   }
#   tags = {
#     Name = "${var.env-prefix}-0${count.index + 1}.Public NAT ${count.index + 1} EIP"
#   }
# }

resource "aws_eip" "cwave-public-nat-eip" {
  count = length(var.subnet-cidrs-cwave-public)
  domain   = "vpc"
  # instance = element(aws_nat_gateway.cwave-public-nat-gateway.*, count.index)
  tags = {
    Name = "${var.env-prefix}-0${count.index + 1}.Public NAT ${count.index + 1} EIP"
  }
}

resource "aws_nat_gateway" "cwave-public-nat-gateway" {
  count = length(var.subnet-cidrs-cwave-public)
  allocation_id = element(aws_eip.cwave-public-nat-eip.*.id, count.index)
  subnet_id     = length(aws_subnet.subnet-cwave-public) > 0 ? element(aws_subnet.subnet-cwave-public.*.id, count.index) : element(var.subnet-cidrs-cwave-public, count.index)
  depends_on = [aws_internet_gateway.cwave-igw]
  tags = {
    Name = "${var.env-prefix}-0${count.index + 1}.Public NAT ${count.index + 1} Gateway"
  }
}