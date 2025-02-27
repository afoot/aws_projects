data "aws_availability_zones" "available" {}

locals {
  name = basename(path.cwd)

  vpc_cidr = "10.0.0.0/16"
  azs      = slice(data.aws_availability_zones.available.names, 0, 3)

  tags = {
    Name = local.name
  }
}

# Create a VPC

module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "~> 5.0"

  name = local.name
  cidr = local.vpc_cidr

  azs             = local.azs
  public_subnets  = [for k, v in local.azs : cidrsubnet(local.vpc_cidr, 8, k)]
  private_subnets = [for k, v in local.azs : cidrsubnet(local.vpc_cidr, 8, k + 10)]

  private_subnet_tags = {
    "Name" = "private"
  }

  public_subnet_tags = {
    "Name" = "public"
  }

  enable_nat_gateway = true
  single_nat_gateway = true

   tags = local.tags
}

# Create a security group

resource "aws_security_group" "web" {
  vpc_id = module.vpc.vpc_id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

    egress {
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }

}

# Create an EC2 instance

resource "aws_instance" "web" {
  ami           = "ami-0e1bed4f06a3b463d"
  instance_type = "t2.micro"
  key_name      = var.aws_key
  security_groups = [aws_security_group.web.name]
  associate_public_ip_address = true
  subnet_id = module.vpc.public_subnets[0]
  user_data = <<-EOF
		           #!/bin/bash
                   sudo apt-get update
		           sudo apt-get install -y apache2
		           sudo systemctl start apache2
		           sudo systemctl enable apache2
		           echo "<h1>Deployed via Terraform from $(hostname -f)</h1>" | sudo tee /var/www/html/index.html
  EOF

  tags = local.tags
}