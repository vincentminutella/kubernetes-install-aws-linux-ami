variable "instance_type" {
    type = string 
    default = "t3.small"
    description = "the default instance type"
}

variable "associate_public_ip_address" {
    type = bool
    default = true
    description = "assign public IPV4"
}

variable "monitoring" {
    type = bool
    default = true
    description = "toggle EC2 monitoring"
}