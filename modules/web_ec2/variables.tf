

variable "image_id" {
  default = "ami-0aef57767f5404a3c"
  type    = string

}

variable "keyname" {
  default     = ["darldev", "darlbaston"]
  type        = list(string)
  description = "keyname for ssh"

}

variable "availability_zone" {
  default = ["eu-west-1a", "eu-west-1b"]
  type    = list(string)

}

variable "instance_type" {
  default = "t2.micro"
  type    = string
}

/*
variable "public_subnet_id" {}

*/

variable "web_interface" {}


