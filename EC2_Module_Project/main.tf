provider "aws" {
	region = "eu-west-1"
	profile = "PaulCarcea-terraform"
}

module "ec2_module" {
	source = "./ec2_module"
}