resource "aws_instance" "vprofile-bastion" {
  ami                    = var.ami
  instance_type          = "t2.micro"
  key_name               = var.key_name
  subnet_id              = module.vpc.public_subnets[0]
  count                  = var.instance_count
  vpc_security_group_ids = [aws_security_group.bastion_sg.id]

  tags = {
    Name    = "bastion"

  }

  provisioner "file" {
    content     = templatefile("templates/db_deploy.tftpl", { rds-endpoint = aws_db_instance.mysql.address, dbuser = var.dbuser, dbpass = var.dbpass })
    destination = "/tmp/dbdeploy.sh"
  }

  provisioner "remote-exec" {
    inline = [
      "chmod +x /tmp/dbdeploy.sh",
      "sudo /tmp/dbdeploy.sh"
    ]
  }

  connection {
    user        = var.user
    private_key = file(var.private_key)
    host        = self.public_ip
  }

  depends_on = [aws_db_instance.rds]
}