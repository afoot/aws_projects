# Create EBS volume
resource "aws_ebs_volume" "ebs_volume" {
  availability_zone = local.azs[0]
  size              = 20
  type              = "gp2"
  tags = {
    Name = "ebs_volume"
  }
}

# Attach EBS volume to EC2 instance
resource "aws_volume_attachment" "ebs_volume_attachment" {
  device_name = "/dev/sdh"
  volume_id   = aws_ebs_volume.ebs_volume.id
  instance_id = aws_instance.web.id
}

# Create EFS file system
resource "aws_efs_file_system" "efs" {
  creation_token   = "efs"
  performance_mode = "generalPurpose"
  throughput_mode  = "bursting"
  encrypted        = true
  lifecycle_policy {
    transition_to_ia = "AFTER_30_DAYS"
  }
  tags = {
    Name = "efs"
  }
}

# Create EFS mount target
resource "aws_efs_mount_target" "efs_mount_target" {
  file_system_id  = aws_efs_file_system.efs.id
  subnet_id       = module.vpc.private_subnets[0]
  security_groups = [aws_security_group.web.id]
}

# Create policy for EFS
resource "aws_efs_file_system_policy" "policy" {
  file_system_id = aws_efs_file_system.efs.id
  policy = jsonencode({
    Version = "2012-10-17",
    Id      = "efs-policy",
    Statement = [
      {
        Effect    = "Allow",
        Principal = "*",
        Action = [
          "elasticfilesystem:ClientMount",
          "elasticfilesystem:ClientWrite",
          "elasticfilesystem:ClientRootAccess"
        ],
        Resource = "*"
      }
    ]
  })
}

# Create access point for EFS
resource "aws_efs_access_point" "efs_access_point" {
  file_system_id = aws_efs_file_system.efs.id
  root_directory {
    path = "/export"
    creation_info {
      owner_uid   = 1000
      owner_gid   = 1000
      permissions = "755"
    }
  }
  posix_user {
    uid = 1000
    gid = 1000
  }
  tags = {
    Name = "efs_access_point"
  }
}

resource "null_resource" "configure_nfs" {
  depends_on = [aws_efs_mount_target.efs_mount_target]

  connection {
    type        = "ssh"
    user        = "ubuntu"
    private_key = file(var.private_key_path)
    host        = aws_instance.web.public_ip
  }
  provisioner "remote-exec" {
    inline = [
      "sudo apt-get update",
      "sudo apt-get install -y nfs-common",
      "sudo mkdir /mnt/efs",
      "sudo mount -t nfs4 -o nfsvers=4.1,rsize=1048576,wsize=1048576,hard,timeo=600,retrans=2 ${aws_efs_file_system.efs.dns_name}:/ /mnt/efs",
      "sudo chmod go+rw /mnt/efs"
    ]
  }
}