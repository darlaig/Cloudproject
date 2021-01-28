

variable "image_id" {
  default = "ami-0aef57767f5404a3c"
  type    = string

}

variable "keyname" {
  default     = ["darldev", "darlbaston"]
  type        = list(any)
  description = "keyname for ssh"

}

variable "availability_zone" {
  default = ["eu-west-1a", "eu-west-1b"]
  type    = list(any)

}

variable "instance_type" {
  default = "t2.micro"
  type    = string
}

variable "public_network_int" {
  default     = ["10.0.0.11", "10.0.0.12", "10.0.0.29"]
  type        = list(string)
  description = "network interface attached to web server instances & bastion server"
}

variable "public_subnet_id" {
  
}
