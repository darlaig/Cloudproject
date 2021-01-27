variable "dynamotable" {
  type = list(object({
    name           = string
    billing_mode   = string
    read_capacity  = number
    write_capacity = number
    hash_key       = string
  }))
  default = [
    {
      name           = "terraform-state"
      billing_mode   = "PROVISIONED"
      read_capacity  = 20
      write_capacity = 20
      hash_key       = "LockID"
    }
  ]
}

variable "env" {
  default = "production"
}
