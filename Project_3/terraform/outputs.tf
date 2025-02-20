output "vps_name" {
  value = module.vpc.vpc_name
 }

output "public_subnets" {
  value = module.vpc.public_subnets
}

output "private_subnets" {
  value = module.vpc.private_subnets
}

output "azs" {
  value = module.vpc.azs
}

output "public_subnets_cidr_blocks" {
  value = module.vpc.public_subnets_cidr_blocks
}
