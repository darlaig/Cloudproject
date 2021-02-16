########## Elastic ip for web server public network interface ###########

resource "aws_eip" "pub1_int" {
  network_interface = var.web_interface
  vpc               = true
}

resource "aws_eip_association" "pub1" {
  instance_id   = aws_instance.web1.id
  allocation_id = aws_eip.pub1_int.id
}

######### Define / associate an elastic ip to web server2 instance  ##########

resource "aws_eip" "pub2_int" {
  network_interface = var.web_interface2
  vpc               = true
}

resource "aws_eip_association" "pub2" {
  instance_id   = aws_instance.web2.id
  allocation_id = aws_eip.pub2_int.id
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