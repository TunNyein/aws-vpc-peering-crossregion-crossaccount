resource "aws_instance" "private_instance01" {
  ami                    = data.aws_ami.private_instance_ami.id
  instance_type          = var.instance_type
  key_name               = aws_key_pair.key-pair.key_name
  subnet_id              = aws_subnet.private_subnet01.id
  vpc_security_group_ids = [aws_security_group.private_sg01.id]

  tags = {
    Name        = "${var.vpc_prefix}-private-instance01"
    environment = "${var.vpc_environment}"
  }
}

