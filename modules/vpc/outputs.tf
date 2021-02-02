

output "vpc_id" {
  value = aws_vpc.dalovpc.id
}


output "public" {
  value = aws_subnet.public["public1"].id
}

output "bastion" {
  value = aws_subnet.public["public2"].id
}


output "private1" {
  value = aws_subnet.private["private1"].id
}

output "private2" {
  value = aws_subnet.private["private2"].id
}
