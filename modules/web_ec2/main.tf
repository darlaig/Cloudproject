terraform {
  required_version = ">= 0.13"
}

# Ec2 instance for web server with a defined network interface

resource "aws_instance" "web1" {
  ami               = var.image_id
  instance_type     = var.instance_type
  availability_zone = var.availability_zone[0]
  key_name          = var.keyname[0]

/*
  network_interface {
    network_interface_id = aws_network_interface.web_public.id
    device_index         = 0
  }
  */

  user_data = file("apache_install.sh")

  tags = {
    Name = "darl-webserver"
  }
}

/*
# Ec2 instance for web server2 with a defined network interface

resource "aws_instance" "web2" {
  ami               = var.image_id
  instance_type     = var.instance_type
  availability_zone = var.availability_zone[1]
  key_name          = var.keyname[0]

  network_interface {
    network_interface_id = aws_network_interface.web_public1.id
    device_index         = 0
  }

  user_data = file("apache_install.sh")

  tags = {
    Name = "darl-webserver2"
  }
}

# Ec2 for Bastion server with a defined network interface

resource "aws_instance" "bastion_server" {
  ami               = var.image_id
  instance_type     = var.instance_type
  availability_zone = var.availability_zone[1]
  key_name          = var.keyname[1]

  network_interface {
    network_interface_id = aws_network_interface.bastion_int.id
    device_index         = 0
  }

  tags = {
    Name = "darl-bastion"
  }
}

/*



*/




########## Public Network interface for Web server 1 ##########

resource "aws_network_interface" "web_public" {
  for_each    = toset(var.public_network_int)
  subnet_id   = var.public_subnet_id
  private_ips = [each.value]
  /*private_ips     = [var.public_network_int[0]]*/
  security_groups = [aws_security_group.allow_web.id]

  tags = {
    Name = "darl-public ${each.value}"
  }
}

/*
##### Elastic ip to web server public network interface ########

resource "aws_eip" "pub_int" {
  network_interface = aws_network_interface.web_public.id
  vpc               = true

}

resource "aws_eip_association" "pub1" {
  instance_id   = aws_instance.web1.id
  allocation_id = aws_eip.pub_int.id
}




# Define / associate an elastic ip to web server2 instance

resource "aws_eip" "pub1_int" {
  network_interface = aws_network_interface.web_public1.id
  vpc               = true
}

resource "aws_eip_association" "pub2" {
  instance_id   = aws_instance.web2.id
  allocation_id = aws_eip.pub1_int.id
}



######## Elastic IP & association  for bastion server   ##############

resource "aws_eip" "bastion" {
  network_interface = aws_network_interface.bastion_int.id
  vpc               = true
}


resource "aws_eip_association" "bastion" {
  instance_id   = aws_instance.bastion_server.id
  allocation_id = aws_eip.bastion.id
}

*/


