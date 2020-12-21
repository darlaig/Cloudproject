# Network interface for Web server 1

resource "aws_network_interface" "web_public" {
  subnet_id       = aws_subnet.public.id
  private_ips     = [var.public_network_int[0]]
  security_groups = [aws_security_group.allow_web.id]
}

# Define / associate an elastic ip to web server public network interface

resource "aws_eip" "pub_int" {
   network_interface = aws_network_interface.web_public.id
   vpc = true

  }

resource "aws_eip_association" "pub1" {
  instance_id = aws_instance.web1.id
  allocation_id = aws_eip.pub_int.id
}

# Network interface for webserver 2

resource "aws_network_interface" "web_public1" {
  subnet_id       = aws_subnet.public1.id
  private_ips     = [var.public_network_int[1]]
  security_groups = [aws_security_group.allow_web.id]
}

# Define / associate an elastic ip to web server2 instance

resource "aws_eip" "pub1_int" {
   network_interface = aws_network_interface.web_public1.id
   vpc = true
 }

resource "aws_eip_association" "pub2" {
  instance_id   = aws_instance.web2.id
  allocation_id = aws_eip.pub1_int.id
}

#Create network interface for bastion server and attached to it instance

resource "aws_network_interface" "bastion_int" {
  subnet_id       = aws_subnet.public.id
  private_ips     = [var.public_network_int[2]]
  security_groups = [aws_security_group.bastion.id]
}

resource "aws_eip" "bastion" {
  network_interface = aws_network_interface.bastion_int.id
  vpc = true
}

output "bastion_server_Eip" {
  value = aws_eip.bastion.public_ip
}

resource "aws_eip_association" "bastion" {
instance_id = "aws_instance.bastion_server.id"
allocation_id = aws_eip.bastion.id
}


# 1st Private network interface 

resource "aws_network_interface" "priv" {
  subnet_id       = aws_subnet.priv1.id
  private_ips     = [var.private_network_int[0]]
  security_groups = [aws_security_group.allow_bastion.id]
}

# 2nd Private network interface 

resource "aws_network_interface" "priv1" {
  subnet_id       = aws_subnet.priv2.id
  private_ips     = [var.private_network_int[1]]
  security_groups = [aws_security_group.allow_bastion.id]
}