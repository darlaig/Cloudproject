# Security group for web servers

resource "aws_security_group" "allow_web" {
  name        = "web_traffic"
  description = "Allow http & ssh inbound traffic"
  vpc_id      = aws_vpc.dalovpc.id

  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = var.public_ssh_ingress[0].cidr_blocks
}

ingress {
    description = "HTTP from ALB"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
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

#Create security group for bastion server

resource "aws_security_group" "bastion" {
  name        = "ssh-to-bastion"
  description = "Admin ssh to bastion"
  vpc_id      = aws_vpc.dalovpc.id

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
  vpc_id      = aws_vpc.dalovpc.id

  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = var.ssh_private[0]
}

 egress {
  from_port   = 0
  to_port     = 0
  protocol    = "-1"
  cidr_blocks = ["0.0.0.0/0"]
   }

tags = {
    Name = var.ssh_private[1]
  }
}

# Security group for load balancer

resource "aws_security_group" "lb_sg" {
  name        = "http_lb"
  description = "Http traffic to load balancer"
  vpc_id      = aws_vpc.dalovpc.id

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