

output "vpc_id" {
  value = aws_vpc.dalovpc.id
}

output "public" {
  value = aws_subnet.public["public1"].id
}


output "subid" {
    value = [for i in aws_subnet.private:i.id]
}


output "private1" {
  value = aws_subnet.private[private1].id
}
