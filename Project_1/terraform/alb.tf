# Deploy S3 bucket for ALB logs

resource "aws_s3_bucket" "alb_logs" {
  bucket_prefix = "alb-logs-" # Prefix for the bucket name
  tags = {
    Name        = "alb-logs"
    Environment = "Dev"
  }
}

# Setup S3 bucket policy

resource "aws_s3_bucket_policy" "alb_logs_policy" {
  bucket = aws_s3_bucket.alb_logs.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          "AWS" : "arn:aws:iam::127311923021:root"
        }
        Action   = "s3:PutObject"
        Resource = "${aws_s3_bucket.alb_logs.arn}/*"
      }
    ]
  })
}

# Setup ALB
resource "aws_lb" "alb" {
  name               = "alb-aws"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.alb_sg.id]
  subnets = [
    module.vpc.public_subnets[0],
    module.vpc.public_subnets[1],
    module.vpc.public_subnets[2]
  ]

  enable_deletion_protection = true

  access_logs {
    bucket  = aws_s3_bucket.alb_logs.id
    prefix  = "alb_aws"
    enabled = true
  }

  tags = {
    Name = "alb"
  }
}

# Setup listener
resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.alb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.app_tg.arn
  }
}

#  Target Group
resource "aws_lb_target_group" "app_tg" {
  name     = "my-app-tg"
  port     = 8080 # Your application port
  protocol = "HTTP"
  vpc_id   = module.vpc.vpc_id

  health_check {
    path                = "/" # Your app's health check path
    protocol            = "HTTP"
    interval            = 30
    timeout             = 10
    healthy_threshold   = 2
    unhealthy_threshold = 2
  }
}
