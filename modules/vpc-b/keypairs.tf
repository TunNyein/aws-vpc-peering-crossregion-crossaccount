locals {
  private_key_filename    = "${var.vpc_prefix}-ssh-key"
  
}

resource "tls_private_key" "keypair" {
  algorithm = "ED25519"
}

resource "aws_key_pair" "key-pair" {
  key_name   = local.private_key_filename
  public_key = tls_private_key.keypair.public_key_openssh
}

resource "local_file" "private_key" {
  content  = tls_private_key.keypair.private_key_openssh
  filename = "${path.root}/generated/${local.private_key_filename}.pem"

  provisioner "local-exec" {
    command = "chmod 400 ${path.root}/generated/${local.private_key_filename}.pem"
  }
}

