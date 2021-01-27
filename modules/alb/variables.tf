variable "environment" {
  default = "darl-production"
}


variable "alb_attributes" {
  type = list(object({
    name               = string
    internal           = bool
    load_balancer_type = string
    ip_address_type    = string
  }))
  default = [
    {
      name               = "darl-alb"
      internal           = false
      load_balancer_type = "application"
      ip_address_type    = "ipv4"
    }
  ]
}