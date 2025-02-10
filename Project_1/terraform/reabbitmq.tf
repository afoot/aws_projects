
resource "aws_mq_broker" "activemq" {
  broker_name         = "activemq-cluster"
  engine_type         = "ActiveMQ"
  engine_version      = "5.17.6"
  host_instance_type  = "mq.t3.micro"
  publicly_accessible = false
  security_groups     = [aws_security_group.activemq_sg.id]
  subnet_ids          = [module.vpc.private_subnets[0]]

  user {
    username = var.rmquser
    password = var.rmqpass
  }

  tags = {
    Name = "activemq-cluster"
  }
}
