output "vpc_id" { 
    value = module.vpc.vpc_id
}

output "public_subnets_cidr_blocks" {
    value = module.vpc.public_subnets_cidr_blocks
}

output "default_security_group_id" {
    value = module.vpc.default_security_group_id
}

output "public_subnets" {
    value = module.vpc.public_subnets
}

output "private_sg" {
  value = aws_security_group.private_access.id
}