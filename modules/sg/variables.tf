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

variable "public_network_int" {
  default     = ["10.0.0.11", "10.0.0.12", "10.0.0.29"]
  type        = list(string)
  description = "network interface attached to web server instances & bastion server"
}

variable "private_network_int" {
  default     = ["10.0.0.40", "10.0.0.60"]
  type        = list(string)
  description = "network interface attached to private servers"

}

variable "public_subnet_id" {}
variable "private_subnet_id" {}
 
 