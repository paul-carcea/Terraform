provider "aws" {
	region = "eu-west-1"
	profile = "PaulCarcea-terraform"
}

module "sg_module" {
	sg_name = "sg_ec2_${local.env}"
	source = "./sg_module"
}

module "ec2_module_1" {
	sg_id = "${module.sg_module.sg_id_output}"
	ec2_name = "EC2_Instance_${local.env}"
	source = "./ec2_module"
}

locals {
	env = "${terraform.workspace}"

	amiID_env { 
		default = "amiID_default"    //error
		staging = "amiID_staging"
		production = "amiID_production"
	}

	amiID = "${lookup(local.amiID_env, local.env)}"
}

output "envSpecificOutput_variable" {
	value = "${local.amiID}"
}