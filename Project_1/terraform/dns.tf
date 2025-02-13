
resource "aws_route53_zone" "internal" {
  name = "saturn.local"
  vpc {
    vpc_id = module.vpc.vpc_id
  }
  comment = "Private hosted zone for saturn.local"
}

resource "aws_route53_record" "app_server" {
  zone_id = aws_route53_zone.internal.zone_id
  name    = "app.saturn.local"
  type    = "A"
  ttl     = "300"
  records = [aws_instance.app.private_ip]

  depends_on = [aws_instance.app]
}

resource "aws_route53_record" "activemq" {
  zone_id = aws_route53_zone.internal.zone_id
  name    = "activemq.saturn.local"
  type    = "A"
  ttl     = "300"
  records = [aws_mq_broker.activemq.instances.0.ip_address]

    depends_on = [aws_mq_broker.activemq]
}

resource "aws_route53_record" "memcached" {
  zone_id = aws_route53_zone.internal.zone_id
  name    = "memcached.saturn.local"
  type    = "A"
  ttl     = "300"
  records = [aws_elasticache_cluster.memcached.cache_nodes.0.address]

  depends_on = [aws_elasticache_cluster.memcached]
}
