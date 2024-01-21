module "vpc" {
  source = "terraform-aws-modules/vpc/aws"
  
  name = var.vpc_name
  cidr = var.cidr_block
  azs  = var.azs
  public_subnets = var.public_subnets

  enable_nat_gateway = var.nat_gateway
  enable_vpn_gateway = var.vpn_gateway

  tags = var.tags
}

resource "aws_security_group" "private_access" {
  name        = "private_access"
  description = "No ingress except authorized console user"
  vpc_id      = "${module.vpc.vpc_id}"

  tags = {}
}