

resource "aws_elasticache_subnet_group" "memcached_subnet_group" {
  name        = "memcached-subnet-group"
  description = "Subnet group for Memcached"
  subnet_ids  = [
    "subnet-12345678",
    "subnet-87654321"
  ]
}

resource "aws_elasticache_cluster" "memcached" {
  cluster_id           = "memcached-cluster"
  engine               = "memcached"
  node_type            = "cache.t3.micro"
  num_cache_nodes      = 1
  parameter_group_name = "default.memcached1.6"
  subnet_group_name    = aws_elasticache_subnet_group.memcached_subnet_group.name
  security_group_ids   = [aws_security_group.memcached_sg.id]

  tags = {
    Name = "memcached-cluster"
  }
}