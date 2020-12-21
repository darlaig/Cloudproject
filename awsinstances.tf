# Ec2 instance for web server with a defined network interface

resource "aws_instance" "web1" {
  ami           = var.image_id
  instance_type = "t2.micro"
  availability_zone = var.availability_zone[0]
  key_name = "darldev"

 network_interface {
   network_interface_id = aws_network_interface.web_public.id
   device_index = 0
 }

  user_data = <<-EOF
                #!/bin/bash
                sudo apt update -y
                sudo apt install apache2 -y
                sudo systemctl start apache2
                sudo bash -c 'echo my web server > /var/www/html/index.html'
                EOF

  tags = {
    Name = "darl-webserver"
  }
}

# Ec2 instance for web server2 with a defined network interface

resource "aws_instance" "web2" {
  ami           = var.image_id
  instance_type = "t2.micro"
  availability_zone = var.availability_zone[1]
  key_name = "darldev"

 network_interface {
   network_interface_id = aws_network_interface.web_public1.id
   device_index = 0
 }

 user_data = <<-EOF
                #!/bin/bash
                sudo apt update -y
                sudo apt install apache2 -y
                sudo systemctl start apache2
                EOF

  tags = {
    Name = "darl-webserver2"
  }
}

# Ec2 for Bastion server with a defined network interface

resource "aws_instance" "bastion_server" {
 ami           = var.image_id
 instance_type = "t2.micro"
 availability_zone = var.availability_zone[1]
 key_name = "darlbaston"

 network_interface {
   network_interface_id = aws_network_interface.bastion_int.id
   device_index = 0
 }

  tags = {
    Name = "darl-bastion"
  }
}

# Ec2 instance for the Dababase server with a defined private network interface

  resource "aws_instance" "priv1" {
     ami           = var.image_id
     instance_type = "t2.micro"
     availability_zone = var.availability_zone[0]
     key_name = "darlbaston"

     network_interface {
       network_interface_id = aws_network_interface.priv.id
       device_index = 0
     }

      tags = {
        Name = "darl-Dbserver1"
      }
  }

# Ec2 instance for the Dababase server with a defined network interface

  resource "aws_instance" "priv2" {
     ami           = var.image_id
     instance_type = "t2.micro"
     availability_zone = var.availability_zone[1]
     key_name = "darlbaston"

     network_interface {
       network_interface_id = aws_network_interface.priv1.id
       device_index = 0
     }

      tags = {
        Name = "darl-dbserver2"
      }
  }