# Defining the VPC block and Internet gateway

resource "aws_vpc" "dalovpc" {
  cidr_block = var.vpc_cidr

  tags = {
    Name = var.name[0]
  }
}
resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.dalovpc.id

  tags = {
    Name = var.name[1]
  }
}



# Custom Public Route table

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.dalovpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }

  tags = {
    Name = "darl-public"
  }
}




# 1st Public subnet and route table association

resource "aws_subnet" "public" {
  vpc_id            = aws_vpc.dalovpc.id
  for_each          = var.public_subnets
  cidr_block        = each.value
  availability_zone = var.availability_zone[0]
  tags = {
    Name = "darl ${each.key}"
  }
}



resource "aws_route_table_association" "public" {
  for_each       = var.public_subnets
  subnet_id      = aws_subnet.public[each.key].id
  route_table_id = aws_route_table.public.id
}







# Eip & Nat gateway for private subnet internet access



resource "aws_eip" "nat" {
  vpc = true
}

resource "aws_nat_gateway" "gw" {
  allocation_id = aws_eip.nat.id
  subnet_id     = aws_subnet.public["public1"].id

  depends_on = [aws_internet_gateway.gw]

  tags = {
    Name = "darl-NATgw"
  }
}

  /*
  resource "aws_eip_association" "nat" {
    allocation_id = aws_eip.nat.id
  }

*/
# Custom private subnet route table


resource "aws_route_table" "private" {
  vpc_id = aws_vpc.dalovpc.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.gw.id
  }


  tags = {
    Name = "darl-private"
  }
}



################## private subnet & route table association ########################


resource "aws_subnet" "private" {
  vpc_id            = aws_vpc.dalovpc.id
  for_each          = var.private_subnets
  cidr_block        = each.value
  availability_zone = var.availability_zone[1]

  tags = {
    Name = "darl ${each.key}"
  }
}

resource "aws_route_table_association" "private" {
  for_each       = var.private_subnets
  subnet_id      = aws_subnet.private[each.key].id
  route_table_id = aws_route_table.private.id
}


