

output "vpc_id" {
  value = aws_vpc.darl_vpc.id
}

output "public1" {
  value = aws_subnet.public["eu-west-1a"].id
}


output "public2" {
  value = aws_subnet.public["eu-west-1b"].id
}


output "private1" {
  value = aws_subnet.private["eu-west-1a"].id
}

output "private2" {
  value = aws_subnet.private["eu-west-1b"].id
}
