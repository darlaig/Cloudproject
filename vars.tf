variable "profile" {}
variable "region" {}

variable "vpc_cidr" {}

variable "availability_zone" {}

variable "image_id" {}

variable "public_subnet_prefix" {
    description = "public subnet cidr blocks"
    type        = list
}

variable "private_subnet_prefix" {
    description = "private subnet cidr blocks"
    type        = list
}
variable "public_network_int" {
    description = "network interface attached to web server instances & bastion server"
    type        = list
}

variable "private_network_int" {
    description = "network interface attached to private servers"
    type        = list
}

variable "public_ssh_ingress" {
    description = "custom ssh ingress to web servers and bastion server"
}

variable "ssh_private" {
    description = " ssh from bastion server to private subnet"
}
