


# Load balancer security group



resource "aws_security_group" "lb_sg" {
  name        = "http_lb"
  description = "Http traffic to load balancer"
  vpc_id      = var.myvpc

  ingress {
    description = "HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "darlalb"
  }
}


# Security group for web servers

resource "aws_security_group" "allow_web" {
  name        = "web_traffic"
  description = "Allow http & ssh inbound traffic"
  vpc_id      = var.myvpc

  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = var.public_ssh_ingress[0].cidr_blocks
  }

  ingress {
    description     = "HTTP from ALB"
    from_port       = 80
    to_port         = 80
    protocol        = "tcp"
    security_groups = [aws_security_group.lb_sg.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = var.public_ssh_ingress[0].name
  }
}



####### Security group for bastion server

resource "aws_security_group" "bastion" {
  name        = "ssh-to-bastion"
  description = "Admin ssh to bastion"
  vpc_id      = var.myvpc

  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = var.public_ssh_ingress[1].cidr_blocks
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = var.public_ssh_ingress[1].name
  }
}




# configure security group for private subnet



resource "aws_security_group" "allow_bastion" {
  name        = "allow_ssh"
  description = "allow ssh from bastion svr"
  vpc_id      = var.myvpc

  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = var.ssh_private[0].cidr_block
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = var.ssh_private[0].name
  }
}




######   Public Network interface for Web server 1

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
# Network interface for webserver 2

resource "aws_network_interface" "web_public1" {
  subnet_id       = aws_subnet.public1.id
  private_ips     = [var.public_network_int[1]]
  security_groups = [aws_security_group.allow_web.id]
}

*/


#Network interface for bastion server

/*
resource "aws_network_interface" "bastion_int" {
  subnet_id       = aws_subnet.public1.id
  private_ips     = [var.public_network_int[2]]
  security_groups = [aws_security_group.bastion.id]
}

*/





/*

########### 2nd Private network interface 

resource "aws_network_interface" "priv1" {
  subnet_id       = aws_subnet.priv2.id
  private_ips     = [var.private_network_int[1]]
  security_groups = [aws_security_group.allow_bastion.id]
}

*/


/*

# Define / associate an elastic ip to web server public network interface

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



# EIP association  for bastion server

resource "aws_eip" "bastion" {
  network_interface = aws_network_interface.bastion_int.id
  vpc               = true
}


resource "aws_eip_association" "bastion" {
  instance_id   = aws_instance.bastion_server.id
  allocation_id = aws_eip.bastion.id
}



*/