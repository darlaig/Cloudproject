


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