terraform {
  required_version = ">= 0.13"
}

# Ec2 instance for web server with a defined network interface

resource "aws_instance" "app" {
  count             = var.instance_count
  ami               = var.image_id
  instance_type     = var.instance_type
  key_name          = element(var.keyname, count.index)
  #subnet_id         = element(var.public_subnet_ids, count.index)
  #security_groups   = var.security_groups
  
  availability_zone = var.azs[count.index % length(var.azs)]

   network_interface {
    network_interface_id = element(var.web_interface, count.index)
    device_index         = 0
  }


  user_data = file("apache_install.sh")

  tags = {
    Name = "darl-webapp-${count.index+1}"
  }
}



# Ec2 instance for web server2 with a defined network interface

/*

resource "aws_instance" "web2" {
  ami               = var.image_id
  instance_type     = var.instance_type
  availability_zone = var.availability_zone[0]
  key_name          = var.keyname[0]

  network_interface {
    network_interface_id = var.web_interface2
    device_index         = 0
  }

  user_data = file("apache_install.sh")

  tags = {
    Name = var.Name
  }
}

*/


/*

#Ec2 for Bastion server with a defined network interface

resource "aws_instance" "bastion_server" {
  ami               = var.image_id
  instance_type     = var.instance_type
  availability_zone = var.availability_zone[1]
  key_name          = var.keyname[0]

  network_interface {
    network_interface_id = var.web_interface2
    device_index         = 0
  }

  tags = {
    Name = "darl-bastion"
  }
}

*/



