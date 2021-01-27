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



*/



