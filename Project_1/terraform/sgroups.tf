# ALB security group 
resource "aws_security_group" "alb_sg" {
  name        = "alb-security-group"
  description = "Security group for ALB"
  vpc_id      = "module.vpc.vpc_id"

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Allow HTTP traffic from anywhere"
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Allow HTTPS traffic from anywhere"
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Allow all outbound traffic"
  }

  tags = {
    Name = "alb-security-group"
  }
}

# ElastiCache security group
resource "aws_security_group" "memcached_sg" {
  name        = "memcached-security-group"
  description = "Security group for Memcached"
  vpc_id      = "module.vpc.vpc_id"

  ingress {
    from_port   = 11211
    to_port     = 11211
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Allow Memcached traffic from application servers"
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Allow all outbound traffic"
  }

  tags = {
    Name = "memcached-security-group"
  }
}

# Rabbit MQ security group
resource "aws_security_group" "activemq_sg_sg" {
  name        = "ractivemq-security-group"
  description = "Security group for ActiveMQ"
  vpc_id      = "module.vpc.vpc_id"

  ingress {
    from_port   = 5671
    to_port     = 5671
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Allow ActiveMQ traffic"
  }

  ingress {
    from_port   = 15672
    to_port     = 15672
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Allow ActiveMQ management traffic"
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Allow all outbound traffic"
  }

  tags = {
    Name = "rabbitmq-security-group"
  }
}

# RDS security group
resource "aws_security_group" "rds_sg" {
  name        = "rds-security-group"
  description = "Security group for RDS for MySQL"
  vpc_id      = "module.vpc.vpc_id"

  ingress {
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Allow traffic to RDS"
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Allow all outbound traffic"
  }

  tags = {
    Name = "rds-security-group"
  }
}

# App security group
resource "aws_security_group" "app_sg" {
  name        = "app-security-group"
  description = "Security group for app"
  vpc_id      = "module.vpc.vpc_id"

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Allow traffic to application servers"
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Allow all outbound traffic"
  }

  tags = {
    Name = "app-security-group"
  }
}