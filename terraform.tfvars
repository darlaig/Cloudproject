region = "eu-west-1"
profile = "darl"
vpc_cidr = "10.0.0.0/24"
image_id = "ami-0aef57767f5404a3c"
availability_zone = ["eu-west-1a", "eu-west-1b"]
public_subnet_prefix = [{cidr_block = "10.0.0.0/28", name = "darl-public1"}, {cidr_block = "10.0.0.16/28", name = "darl-public2"}]
private_subnet_prefix = [{cidr_block = "10.0.0.32/28", name = "darl-private1"}, {cidr_block = "10.0.0.48/28", name = "darl-private2"}]
public_network_int = ["10.0.0.13","10.0.0.24","10.0.0.29"]
private_network_int = ["10.0.0.40","10.0.0.58"]
public_ssh_ingress = [{cidr_blocks = ["81.98.240.119/32"], name = "darl-webtraffic"}, {cidr_blocks = ["81.98.240.119/32"], name = "darl-bastion"}]
ssh_private = [["10.0.0.29/32"],"darl-private"]


