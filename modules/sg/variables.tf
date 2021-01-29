variable "myvpc" {}

variable "public_ssh_ingress" {
  default     = [{ cidr_blocks = ["90.195.144.185/32"], name = "darl-webtraffic" }, { cidr_blocks = ["81.98.240.119/32"], name = "darl-bastion" }]
  type        = list(any)
  description = "custom ssh ingress to web servers and bastion server"
}

variable "ssh_private" {
  default     = [{ cidr_block = ["10.0.0.29/32"], name = "darl-private" }]
  type        = list(any)
  description = " ssh from bastion server to private subnet"
}



variable "web_interface" {
  default     = {
    web1 = "10.0.0.11"
    web2 = "10.0.0.12"
  }
  type        = map
  description = "network interface attached to web server instances"
}

/*
variable "public_subnet" {}
*/

