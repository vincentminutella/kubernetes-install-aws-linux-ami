provider "aws" {
  region  = var.region
}

module "vpc" {
  source = ".//modules/vpc" 
}

module "ec2_instance" {
  source = ".//modules/ec2_instance"
}