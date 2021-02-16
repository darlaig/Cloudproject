variable "vpc_cidr" {
  default = "10.0.0.0/24"
  type    = string
}


variable "public_subnets" {
  default = {
    eu-west-1a = "10.0.0.0/28"
    eu-west-1b = "10.0.0.16/28"
  }
  type        = map(any)
  description = "public subnet cidr blocks"
}

variable "private_subnets" {
  default = {
    eu-west-1a = "10.0.0.32/28"
    eu-west-1b = "10.0.0.48/28"
  }
  type        = map(any)
  description = "private subnet cidr blocks"
}

variable "name" {
  default     = ["darl-vpc", "darl-igw"]
  type        = list(string)
  description = "vpc and internet gw tagged names"

}



