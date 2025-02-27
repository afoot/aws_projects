output "vpc_id" {
  description = "The ID of the VPC"
  value       = module.vpc.vpc_id
}

output "public_subnets" {
  description = "A list of public subnets"
  value       = module.vpc.public_subnets
}

output "private_subnets" {
  description = "A list of private subnets for the client app"
  value       = module.vpc.private_subnets
}

output "private_subnets_cidr_blocks" {
  description = "A list of private subnets CIDRs"
  value       = module.vpc.private_subnets_cidr_blocks
}

output "public_subnets_cidr_blocks" {
  description = "A list of public subnets CIDRs"
  value       = module.vpc.public_subnets_cidr_blocks
}

output "public_ec2_ips" {
  description = "A list of public IPs for the EC2 instances"
  value       = [aws_instance.web.*.public_ip]
  }