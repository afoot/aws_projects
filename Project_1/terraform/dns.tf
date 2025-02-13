provider "aws" {
  region = "us-west-2"
}

resource "aws_route53_zone" "internal" {
  name = "internal.example.com"
  vpc {
    vpc_id = "vpc-xxxxxxxx"
  }
  comment = "Private hosted zone for internal.example.com"
}

resource "aws_instance" "app_server" {
  ami           = "ami-xxxxxxxx"
  instance_type = "t2.micro"
  subnet_id     = "subnet-xxxxxxxx"
  tags = {
    Name = "AppServer"
  }
}

resource "aws_instance" "activemq" {
  ami           = "ami-xxxxxxxx"
  instance_type = "t2.micro"
  subnet_id     = "subnet-xxxxxxxx"
  tags = {
    Name = "ActiveMQ"
  }
}

resource "aws_instance" "memcached" {
  ami           = "ami-xxxxxxxx"
  instance_type = "t2.micro"
  subnet_id     = "subnet-xxxxxxxx"
  tags = {
    Name = "Memcached"
  }
}

resource "aws_route53_record" "app_server" {
  zone_id = aws_route53_zone.internal.zone_id
  name    = "app.internal.example.com"
  type    = "A"
  ttl     = "300"
  records = [aws_instance.app_server.private_ip]
}

resource "aws_route53_record" "activemq" {
  zone_id = aws_route53_zone.internal.zone_id
  name    = "activemq.internal.example.com"
  type    = "A"
  ttl     = "300"
  records = [aws_instance.activemq.private_ip]
}

resource "aws_route53_record" "memcached" {
  zone_id = aws_route53_zone.internal.zone_id
  name    = "memcached.internal.example.com"
  type    = "A"
  ttl     = "300"
  records = [aws_instance.memcached.private_ip]
}
