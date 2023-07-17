# CloudWave VPC BASTION
resource "aws_instance" "bastion" {
  ami = "ami-027ce4ce0590e3c98" // 리눅스 이미지
  instance_type = "t2.large"
  subnet_id = aws_subnet.subnet-cwave-public[0].id
  key_name = aws_key_pair.cwave-bastion-node-key.key_name
  vpc_security_group_ids = [aws_security_group.cwave-bastion-sg.id]
  associate_public_ip_address = true
  metadata_options {
    http_endpoint = "enabled"
    http_tokens = "required"
  }

  root_block_device {
    delete_on_termination = true
    encrypted = true
    volume_size = "100"
    volume_type = "gp3"
  }

  depends_on = [
    aws_route_table.cwave-public-route-table,
    aws_route_table_association.cwave-public-route-table-asc
  ]

  tags = {
    "Name" = "${var.env-prefix}-cwave-bastionHost"
  }
}

resource "aws_eip" "bastion" {
  domain   = "vpc"
  instance = aws_instance.bastion.id
}
