provider "aws" {
	profile = "PaulCarcea-terraform"
	region = "eu-west-2"
}

module "network_module" {
	source = "./network_module"
}

module "loadbalancer_module" {
	source = "./loadbalancer_module"
	publicSG_ID = "${module.network_module.publicSG_ID}"
}

module "autoscaling_module" {
	source = "./autoscaling_module"
	privateSG_ID = "${module.network_module.privateSG_ID}"
	tg_arn = "${module.loadbalancer_module.tg_arn}"
}