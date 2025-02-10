# 1. Launch an Initial Instance (for configuration)

resource "aws_instance" "app" {
  ami           = var.ami
  instance_type = var.instance_type
  key_name      = "aws_projects"
  user_data     = file("templates/setup_instance.sh") # Script to configure the instance

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

resource "aws_launch_configuration" "app_lc" {
  name_prefix   = "lc-"
  image_id      = aws_ami_from_instance.ami.id
  instance_type = var.instance_type
}

# 4. Auto Scaling Group (using the Launch Configuration)

resource "aws_autoscaling_group" "app_asg" {
  name                 = "app-asg"
  launch_configuration = aws_launch_configuration.app_lc.name
  min_size             = 2
  max_size             = 4
  desired_capacity     = 2
  vpc_zone_identifier  = [module.vpc.public_subnets[0], module.vpc.public_subnets[1], module.vpc.public_subnets[2]] # Subnets for your instances
  health_check_type    = "ELB"                                                                                      # Or "EC2" if not using a load balancer
}

# 5. Target Group and Attachment (same as before)

resource "aws_autoscaling_attachment" "asg_tg_attachment" {
  autoscaling_group_name = aws_autoscaling_group.app_asg.name
  lb_target_group_arn    = aws_lb_target_group.app_tg.arn
}