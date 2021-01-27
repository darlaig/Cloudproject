variable "image_id" {
    default = "ami-0aef57767f5404a3c"
  
}

variable "instance_type" {
    default = "t2.micro"
    type    = string

}

variable "keyname" {
    default = "darlbaston"
    type    = string

}

variable "availability_zone" {}

