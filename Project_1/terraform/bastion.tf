resource "aws_instance" "bastion" {
  ami                    = var.ami
  instance_type          = var.instance_type
  key_name               = var.key_name
  count                  = var.instance_count
  subnet_id              = module.vpc.public_subnets[0]
  vpc_security_group_ids = [aws_security_group.bastion_sg.id]
  associate_public_ip_address = true

  tags = {
    Name = "bastion"

  }

  provisioner "file" {
    content = templatefile("templates/db_deploy.tftpl", {
      rds-endpoint = aws_db_instance.mysql.address,
      dbuser       = var.dbuser,
      dbpass       = var.dbpass
    })
    destination = "/tmp/dbdeploy.sh"

    connection {
      type        = "ssh"
      user        = var.user
      private_key = local.private_key
      host        = self.public_ip
    }
  }

  provisioner "remote-exec" {
    inline = [
      "chmod +x /tmp/dbdeploy.sh",
      "sudo /tmp/dbdeploy.sh"
    ]

    connection {
      type        = "ssh"
      user        = var.user
      private_key = local.private_key
      host        = self.public_ip
    }
  }
  depends_on = [aws_db_instance.mysql]
}

