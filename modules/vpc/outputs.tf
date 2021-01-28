

output "vpc_id" {
  value = aws_vpc.dalovpc.id
}

/*
output "public" {
  value = aws_subnet.public["public1"].id
}
*/

output "public" {
  value = {for i, k in aws_subnet.public: i => k.id}
}

output "private" {
  value = {for i, k in aws_subnet.private: i => k.id}
}





/*
output "private1" {
  value = aws_subnet.private[private1].id
}
*/