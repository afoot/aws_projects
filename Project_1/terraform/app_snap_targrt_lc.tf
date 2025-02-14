# 1. Launch an Initial Instance (for configuration)

resource "aws_instance" "app" {
  ami                    = var.ami
  instance_type          = var.instance_type
  key_name               = var.key_name
  subnet_id              = module.vpc.public_subnets[0]
  user_data              = file("templates/setup_instance.sh") # Script to configure the instance
  vpc_security_group_ids = [aws_security_group.app_sg.id]
  iam_instance_profile   = aws_iam_instance_profile.ec2_s3_access_profile.name

  provisioner "local-exec" {
    command = "aws ec2 wait instance-status-ok --instance-ids ${self.id}"
  }
}

# 2. Create an AMI from the Instance

resource "aws_ami_from_instance" "ami" {
  name               = "ami-from-instance"
  description        = "AMI from instance ${aws_instance.app.id}"
  source_instance_id = aws_instance.app.id
  # Important:  This depends on the instance.  Terraform will wait for the instance to be created.
  depends_on = [aws_instance.app]
}

# 3. Launch Configuration (using the AMI)

resource "aws_launch_template" "app_lt" {
  name_prefix            = "lt-"
  image_id               = aws_ami_from_instance.ami.id
  instance_type          = var.instance_type
  key_name               = "aws_projects"
  vpc_security_group_ids = [aws_security_group.app_sg.id]

  network_interfaces {
    associate_public_ip_address = true
    device_index                = 0
  }

  iam_instance_profile {
    name = aws_iam_instance_profile.ec2_s3_access_profile.name
  }
}

# 4. Auto Scaling Group (using the Launch Configuration)

resource "aws_autoscaling_group" "app_asg" {
  name                = "app-asg"
  min_size            = 2
  max_size            = 3
  desired_capacity    = 2
  vpc_zone_identifier = [module.vpc.public_subnets[0], module.vpc.public_subnets[1], module.vpc.public_subnets[2]] # Subnets for your instances
  health_check_type   = "ELB"

  launch_template {
    id      = aws_launch_template.app_lt.id
    version = "$Latest"
  }
  tag {
    key                 = "Name"
    value               = "app-asg"
    propagate_at_launch = true
  }
}

# 5. Target Group and Attachment (same as before)

resource "aws_autoscaling_attachment" "asg_tg_attachment" {
  autoscaling_group_name = aws_autoscaling_group.app_asg.name
  lb_target_group_arn    = aws_lb_target_group.app_tg.arn
}