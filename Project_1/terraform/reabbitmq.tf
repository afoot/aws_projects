
resource "aws_mq_broker" "rabbitmq" {
  broker_name         = "rabbitmq-cluster"
  engine_type         = "RabbitMQ"
  engine_version      = "3.13"
  instance_type       = "mq.t3.micro"
  publicly_accessible = false
  security_groups     = [aws_security_group.rabbitmq_sg.id]
  subnet_ids          = [
    module.vpc.private_subnets[0], 
    module.vpc.private_subnets[1], 
    module.vpc.private_subnets[2]
]

  user {
    username = ""
    password = ""
  }

  tags   = {
    Name = "rabbitmq-cluster"
  }
}
