# Ec2 instance for the Dababase server with a defined private network interface

resource "aws_instance" "priv1" {
  ami               = var.image_id
  instance_type     = var.instance_type
  availability_zone = var.availability_zone
  key_name          = var.keyname

  network_interface {
    network_interface_id = aws_network_interface.priv.id
    device_index         = 0
  }

  tags = {
    Name = "darl-Dbserver"
  }
}


################## Private network interface  ########################

resource "aws_network_interface" "priv" {
  for_each        = toset(var.private_network_int)
  private_ips     = [each.value]
  subnet_id       = var.private_subnet_id
  security_groups = [aws_security_group.allow_bastion.id]


  tags = {
    Name = "darl-private ${each.value}"
  }
}


/*
# Ec2 instance for the Database server with a defined network interface

resource "aws_instance" "priv2" {
  ami               = var.image_id
  instance_type     = var.instance_type
  availability_zone = var.availability_zone[1]
  key_name          = var.keyname

  network_interface {
    network_interface_id = aws_network_interface.priv1.id
    device_index         = 0
  }

  tags = {
    Name = "darl-dbserver2"
  }
}


*/