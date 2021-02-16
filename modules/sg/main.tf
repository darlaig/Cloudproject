############### Load balancer security group ##############

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

############### Security group for web servers ##############

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
    description = "jenkins"
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = var.public_ssh_ingress[0].cidr_blocks
  }
  /*
  ingress {
    description     = "HTTP from ALB"
    from_port       = 80
    to_port         = 80
    protocol        = "tcp"
    security_groups = [aws_security_group.lb_sg.id]
  }
  */

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

############## Security group for bastion server ##############

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

############## security group for private subnet   ##################

resource "aws_security_group" "allow_bastion" {
  name        = "allow_ssh"
  description = "allow ssh from bastion server"
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

########## Public Network interface for Web server 1 ##########

resource "aws_network_interface" "public1" {
  for_each        = var.public1_interface
  subnet_id       = var.public1_subnet_id
  private_ips     = [each.value]
  security_groups = [aws_security_group.allow_web.id,aws_security_group.bastion.id]

  tags = {
    Name = "darl-public1-${each.key}"
  }
}

############ Network interface for bastion server ##############

resource "aws_network_interface" "public2" {
  for_each        = var.public2_interface
  subnet_id       = var.public2_subnet_id
  private_ips     = [each.value]
  security_groups = [aws_security_group.allow_web.id,aws_security_group.bastion.id]

  tags = {
    Name = "darl-public2-${each.key}"
  }
}


################## Private network interface  ########################

resource "aws_network_interface" "priv1" {
  private_ips     = var.db_interface[0].private_ip
  subnet_id       = var.private1_subnet_id
  security_groups = [aws_security_group.allow_bastion.id]


  tags = {
    Name = var.db_interface[0].name
  }
}


resource "aws_network_interface" "priv2" {
  private_ips     = var.db_interface[1].private_ip
  subnet_id       = var.private2_subnet_id
  security_groups = [aws_security_group.allow_bastion.id]


  tags = {
    Name = var.db_interface[1].name
  }
}
