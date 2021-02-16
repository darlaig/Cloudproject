variable "myvpc" {}

variable "public_ssh_ingress" {
  default     = [{ cidr_blocks = ["90.201.148.41/32"], name = "darl-webtraffic" }, { cidr_blocks = ["81.98.240.119/32"], name = "darl-bastion" }]
  type        = list(any)
  description = "custom ssh ingress to web servers and bastion server"
}

variable "ssh_private" {
  default     = [{ cidr_block = ["10.0.0.12/32"], name = "darl-private" }]
  type        = list(any)
  description = " ssh from bastion server to private subnet"
}

variable "public1_subnet_id" {}

variable "public1_interface" {
  default = {
    web1    = "10.0.0.11"
    bastion = "10.0.0.12"
  }
  type        = map(any)
  description = "network interface attached to web server instances"
}

variable "public2_subnet_id" {}

variable "public2_interface" {
  default = {
    web2       = "10.0.0.20"
    k8         = "10.0.0.21"
    jenkins    = "10.0.0.22"

  }

  type        = map(any)
  description = "network interfaces for managment"
}



variable "private1_subnet_id" {}
variable "private2_subnet_id" {}

variable "db_interface" {
  default = [{ private_ip = ["10.0.0.40"], name = "darl-db-server1" },
  { private_ip = ["10.0.0.60"], name = "darl-db-server2" }]

  type        = list(any)
  description = "database1 network interface"

}



/*
variable "db2_network_int"  {
  default = "10.0.0.60"
  type        = string
  description = "Database2 network interface"

}
*/




