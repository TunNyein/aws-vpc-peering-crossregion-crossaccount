
resource "aws_eip" "public_instance_eip" {

  tags = {
    name        = "${var.vpc_prefix}-public-instance-eip"
    environment = "${var.vpc_environment}"
  }
}

resource "aws_eip_association" "public_instance_eip_assoc" {
  instance_id   = aws_instance.public_instance01.id
  allocation_id = aws_eip.public_instance_eip.id
}


resource "aws_instance" "public_instance01" {
  ami                    = data.aws_ami.public_instance_ami.id
  instance_type          = var.instance_type
  key_name               = aws_key_pair.key-pair.key_name
  subnet_id              = aws_subnet.public_subnet01.id
  vpc_security_group_ids = [aws_security_group.public_sg01.id]

  tags = {
    Name        = "${var.vpc_prefix}-public-instance01"
    environment = "${var.vpc_environment}"
  }
  # lifecycle {
  #   prevent_destroy = true # safety: Terraform won’t destroy this EC2 by mistake
  #   ignore_changes = [
  #     ami,      # changing AMI won't replace the instance
  #     tags,     # tag updates won’t force recreation
  #     user_data # if you later add/change user_data, won’t force recreation
  #   ]
  # }
}

resource "null_resource" "configure-public-instance01" {
  depends_on = [aws_instance.public_instance01, aws_eip_association.public_instance_eip_assoc]

  triggers = {
    build_number = timestamp()
  }

provisioner "file" {
    source      = "${path.module}/files/"
    destination = "/home/ec2-user/"

    connection {
      type        = "ssh"
      user        = "ec2-user"
      private_key = tls_private_key.keypair.private_key_pem
      host        = aws_eip.public_instance_eip.public_ip
    }
  }

provisioner "remote-exec" {
    inline = [
      # Update YUM-based package index
      "sudo yum -y update",

      # Install Apache httpd only if not present
      "if ! rpm -q httpd >/dev/null 2>&1; then sudo yum -y install httpd; fi",
      "sudo systemctl enable httpd",
      "sudo systemctl start httpd",

      # Fix permissions if directory exists
      "if [ -d /var/www/html ]; then sudo chown -R ec2-user:ec2-user /var/www/html; fi",

      # Make scripts executable if any exist
      "if ls *.sh 1> /dev/null 2>&1; then chmod +x *.sh; fi",

      # Run your deployment script if it exists
      "if [ -f ./deploy_app.sh ]; then PLACEHOLDER=${var.placeholder} WIDTH=${var.width} HEIGHT=${var.height} PLACEHOLDER_ID=${var.placeholder_id} PREFIX=${var.vpc_prefix} ./deploy_app.sh; fi",

      # Install cowsay if not present
      "if ! command -v cowsay >/dev/null 2>&1; then sudo yum -y install cowsay; fi",
      "cowsay Hellooooooooooo!",
    ]

    connection {
      type        = "ssh"
      user        = "ec2-user"
      private_key = tls_private_key.keypair.private_key_pem
      host        = aws_eip.public_instance_eip.public_ip
    }
  }
}
