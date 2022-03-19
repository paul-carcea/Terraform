output "vpcid" {
	value = "${local.vpcid}"
}

output "publicSubnetID1" {
	value = "${local.publicSubnetID1}"
}

output "publicSubnetID2" {
	value = "${local.publicSubnetID2}"
}

output "privateSubnetID" {
	value = "${local.privateSubnetID}"
}

output "env_suffix" {
	value = "${local.env}"
}

locals {
	env = "${terraform.workspace}"

	vpcid_env = {
		default = "vpc-0859c445d93fc9895"
		staging = "vpc-0859c445d93fc9895"
		production = "vpc-0859c445d93fc9895"
	}
	vpcid = "${lookup(local.vpcid_env, local.env)}"

	publicSubnetID1_env = {
		default = "subnet-0d91e8e4a3266b3ed"
		staging = "subnet-0d91e8e4a3266b3ed"
		production = "subnet-0d91e8e4a3266b3ed"
	}
	publicSubnetID1 = "${lookup(local.publicSubnetID1_env, local.env)}"

	publicSubnetID2_env = {
		default = "subnet-010a5807ab48043d4"
		staging = "subnet-010a5807ab48043d4"
		production = "subnet-010a5807ab48043d4"
	}
	publicSubnetID2 = "${lookup(local.publicSubnetID2_env, local.env)}"

	privateSubnetID_env = {
		default = "subnet-07bf06ebc89d3ce7b"
		staging = "subnet-07bf06ebc89d3ce7b"
		production = "subnet-07bf06ebc89d3ce7b"
	}
	privateSubnetID = "${lookup(local.privateSubnetID_env, local.env)}"
}

