

/*
data "aws_vpc" "dalovpc" {
id = aws_vpc.dalovpc.id
}


*/

/*

data "aws_subnet_ids" "public" {
  vpc_id = aws_vpc.dalovpc.id
}



data "aws_subnet" "public" {
  for_each = data.aws_subnet_ids.public.ids
  id = each.value
}

*/
/*


data "aws_subnet_ids" "private" {
  vpc_id = aws_vpc.dalovpc.id
}

data "aws_subnet" "private" {
  for_each = data.aws_subnet_ids.private.ids
  id       = each.value 

}






/*
output "subnet_cidr_blocks" {
  value = [for s in data.aws_subnet.public : s.cidr_block]
}

*/







