output "eip_web1" {
  value = aws_eip.pub_int.id
}

output "eip_association_web1" {
  value = aws_eip_association.pub1.id

}