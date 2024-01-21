variable "vpc_name" {
    type = string
    description = "the vpc name"
    default = "k8s-vpc"
}

variable "cidr_block" {
    type = string 
    description = "vpc cidr"
    default = "10.0.0.0/16"
}

variable "public_subnets" {
    type = list(string) 
    description = "the cidr of the subnets for the vpc"
    default = ["10.0.1.0/28", "10.0.2.0/28"]
}

variable "azs" {
    type = list(string) 
    description = "the azs of the subnets"
    default = ["us-west-1a", "us-west-1c"]
}

variable "nat_gateway" {
    type = bool
    description = "enable nat gateway"
    default = false
}

variable "vpn_gateway" {
    type = bool
    description = "enable vpn gateway"
    default = false
}

variable "tags" {
    type = map(string)
    description = "tags for the vpc"
    default = {
      Name = "k8s-vpc"
      Owner = "vincent"
    }
}