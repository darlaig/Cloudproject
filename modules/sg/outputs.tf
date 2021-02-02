


output "web1_interface" {
  value = aws_network_interface.web["web1"].id
}

output "web2_interface" {
  value = aws_network_interface.web["web2"].id
}


output "lb_security_group_id" {
  value = aws_security_group.lb_sg.id
}

output "web_security_group_id" {
  value = aws_security_group.allow_web.id
}


output "bastion_security_group_id" {
  value = aws_security_group.bastion.id
}

output "private_subnet_security_group_id" {
  value = aws_security_group.allow_bastion.id
}





