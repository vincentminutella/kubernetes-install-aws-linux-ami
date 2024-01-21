module "ec2_instance" {
  source  = "terraform-aws-modules/ec2-instance/aws"

  for_each = toset(["master", "worker1", "worker2"])

  name = "k8s-${each.key}"

  instance_type               = var.instance_type
  key_name                    = "node-key"
  monitoring                  = var.monitoring
  vpc_security_group_ids      = [module.vpc.private_sg]
  subnet_id                   = module.vpc.public_subnets[1]
  ami                         = "${data.aws_ami.amazon-linux-2023.id}"
  associate_public_ip_address = var.associate_public_ip_address

  tags = {
    Name = "k8s-${each.key}"
    Owner = "vincent"
  }
}


data "aws_ami" "amazon-linux-2023" {
 most_recent = true

  filter {
   name   = "owner-alias"
   values = ["amazon"]
 }


 filter {
   name   = "name"
   values = ["al2023-ami-2023*"]
 }

 filter {
   name = "architecture"
   values = ["x86_64"]
 }
}

module "vpc" {
    source = "../vpc"
}

