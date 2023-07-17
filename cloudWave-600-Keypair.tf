# CloudWave vm access key pair
resource "aws_key_pair" "cwave-eks-node-key" {
  key_name = "cwave-eks-node-key-pair" # 생성될 키페어의 이름
  public_key = file("cert/${var.env-prefix}-eks-node-key.pub")
}

resource "aws_key_pair" "cwave-bastion-node-key" {
  key_name = "cwave-bastion-node-key-pair" # 생성될 키페어의 이름
  public_key = file("cert/${var.env-prefix}-bastion-node-key.pub")
}