# CloudWave Bastion Security Group
resource "aws_security_group" "cwave-bastion-sg" {
  name = "bastion to cwave eks security group"
  description = "bastion"
  vpc_id = aws_vpc.cwave-vpc.id
  
  ## Allow SSH Inboud traffic.
  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = var.allow-ip-cidr-to-bastion
  }

  ## Allow all Outbound traffic.
  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    "Name" = "${var.env-prefix}-bastion-to-sg"
  }
}

# CloudWave Common Security Group
resource "aws_security_group" "remote_access" {
  name_prefix = "${var.cwave-cluster-name}-remote-access"
  description = "Allow remote SSH access"
  vpc_id      = aws_vpc.cwave-vpc.id

  ingress {
    description = "SSH access"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["10.0.0.0/8"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
  tags = {
    Name = var.cwave-cluster-name
  }
}