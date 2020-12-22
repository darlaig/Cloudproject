
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
  vpc_id     = aws_vpc.dalovpc.id
  cidr_block = var.public_subnet_prefix[0].cidr_block
  availability_zone = var.availability_zone[0]
  tags = {
    Name = var.public_subnet_prefix[0].name
  }
}

output "first_public_cidrblock" {
  value = aws_subnet.public.cidr_block
}

resource "aws_route_table_association" "public" {
  subnet_id      = aws_subnet.public.id
  route_table_id = aws_route_table.public.id
}

# 2nd Public subnet and route table association

resource "aws_subnet" "public1" {
  vpc_id     = aws_vpc.dalovpc.id
  cidr_block = var.public_subnet_prefix[1].cidr_block
  availability_zone = var.availability_zone[1]

  tags = {
    Name = var.public_subnet_prefix[1].name
  }
}



resource "aws_route_table_association" "public1" {
      subnet_id      = aws_subnet.public1.id
      route_table_id = aws_route_table.public.id
 }

 



# 1st private subnet and route table association

resource "aws_subnet" "priv1" {
  vpc_id     = aws_vpc.dalovpc.id
  cidr_block = var.private_subnet_prefix[0].cidr_block
  availability_zone = var.availability_zone[0]

  tags = {
    Name = var.private_subnet_prefix[0].name
   }
}

output "first_private_server_cidrblock" {
  value = aws_subnet.priv1.cidr_block
}

resource "aws_route_table_association" "priv1" {
      subnet_id      = aws_subnet.priv1.id
      route_table_id = aws_route_table.private.id
 }

# 2nd private subnet 

resource "aws_subnet" "priv2" {
  vpc_id     = aws_vpc.dalovpc.id
  cidr_block = var.private_subnet_prefix[1].cidr_block
  availability_zone = var.availability_zone[1]

  tags = {
    Name = var.private_subnet_prefix[1].name
   }
}

output "second_private_server_cidrblock" {
  value = aws_subnet.priv2.cidr_block
}

resource "aws_route_table_association" "priv2" {
      subnet_id      = aws_subnet.priv2.id
      route_table_id = aws_route_table.private.id
 }

# Nat gateway for private subnet internet access

resource "aws_nat_gateway" "gw" {
  allocation_id = aws_eip.nat.id
  subnet_id     = aws_subnet.public.id

  tags = {
   Name = "darl-NATgw"
 }
}

resource "aws_eip" "nat" {
  vpc      = true
  }

  resource "aws_eip_association" "nat" {
    allocation_id = aws_eip.nat.id
  }



# Custom private subnet route table

resource "aws_route_table" "private" {
  vpc_id = aws_vpc.dalovpc.id

  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.gw.id
  }


  tags = {
    Name = "darl-private"
  }
}