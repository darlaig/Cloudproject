# Defining the VPC block and Internet gateway

resource "aws_vpc" "dalovpc" {
   cidr_block = var.vpc_cidr

   tags = {
      Name = "darlvpc"
   }
}

resource "aws_internet_gateway" "gw" {
   vpc_id = aws_vpc.dalovpc.id

  tags = {
    Name = "darligw"
  }
}