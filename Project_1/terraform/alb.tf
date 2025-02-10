
# Setup ALB
resource "aws_lb" "alb" {
  name               = "alb-aws"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.lb_sg.id]
  subnets            = [for subnet in aws_subnet.public : subnet.id]

  enable_deletion_protection = true

  access_logs {
    bucket  = aws_s3_bucket.lb_logs.id
    prefix  = "alb_aws"
    enabled = true
  }

  tags = {
    Name = "alb"
  }
}

# Setup listener
resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.app_lb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type = "forward"
    target_group_arn = aws_lb_target_group.app_tg.arn
  }
}

#  Target Group
resource "aws_lb_target_group" "app_tg" {
  name     = "my-app-tg"
  port     = 80 # Your application port
  protocol = "HTTP"
  vpc_id   = aws_vpc.main.id

  health_check {
    path               = "/" # Your app's health check path
    protocol           = "HTTP"
    interval           = 30
    timeout            = 10
    healthy_threshold  = 2
    unhealthy_threshold = 2
  }
}
