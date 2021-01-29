
/* 
variable "vpc_id" {}
*/




variable "vpc_cidr" {
  default = "10.0.0.0/24"
  type    = string
}


variable "availability_zone" {
  default = ["eu-west-1a", "eu-west-1b"]
  type    = list(string)
}


variable "public_subnets"{
   default =  {
    public1 = "10.0.0.0/28"
    public2 = "10.0.0.16/28"
    }
    type = map
    description = "public subnet"
}

variable "web_interface" {
  default     = {
    web1 = "10.0.0.11"
    web2 = "10.0.0.12"
  }
  type        = map
  description = "network interface attached to web server instances"
}


variable "private_subnets" {
  default     = {
    private1 = "10.0.0.32/28"
    private2 = "10.0.0.48/28"
  }
  type        = map
  description = "private subnet cidr blocks"
}

variable "name" {
  default     = ["darl-vpc", "darl-igw"]
  type        = list(string)
  description = "vpc and internet gw tagged names"

}



