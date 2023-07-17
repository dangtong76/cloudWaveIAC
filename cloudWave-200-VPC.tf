############################################################################################
## CloudWave VPC 생성
############################################################################################

resource "aws_vpc" "cwave-vpc" {
  cidr_block = var.cwave-vpc-cidr
  enable_dns_support = true
  enable_dns_hostnames = true
  tags = {
    Name = "VPC-${var.env-prefix}"
    "kubernetes.io/cluster/${var.cwave-cluster-name}" = "shared"
  }
}