# CloudWave Public VPC Internet Gateway
resource "aws_internet_gateway" "cwave-igw" {
  vpc_id = aws_vpc.cwave-vpc.id
  tags = {
    Name = "${var.env-prefix}-IGW"
  }
}