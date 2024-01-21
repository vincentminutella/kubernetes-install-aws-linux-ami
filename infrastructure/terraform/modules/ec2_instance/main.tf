module "ec2_instance" {
  source  = "terraform-aws-modules/ec2-instance/aws"

  for_each = toset(["master", "worker1", "worker2"])

  name = "k8s-${each.key}"

  instance_type               = var.instance_type
  key_name                    = "node-key"
  monitoring                  = var.monitoring
  vpc_security_group_ids      = [module.vpc.private_sg]
  subnet_id                   = module.vpc.public_subnets[1]
  ami                         = "ami-0ce2cb35386fc22e9"
  associate_public_ip_address = var.associate_public_ip_address

  tags = {
    Name = "k8s-${each.key}"
    Owner = "vincent"
  }
}

module "vpc" {
    source = "../vpc"
}

