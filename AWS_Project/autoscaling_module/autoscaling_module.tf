module "shared_vars" {
  source = "../shared_vars"
}

variable tg_arn {}

variable privateSG_ID {}

locals {
  env = "${terraform.workspace}"
  amiID_env = {
    default = "ami-0dd555eb7eb3b7c82"
    staging = "ami-0dd555eb7eb3b7c82"
    production = "ami-0dd555eb7eb3b7c82"
  }
  amiID = "${lookup(local.amiID_env, local.env)}"

  instanceType_env = {
    default = "t2.micro"
    staging = "t2.micro"
    production = "t2.medium"
  }
  instanceType = "${lookup(local.instanceType_env, local.env)}"

  keyPairName_env = {
    default = "aws_project_terraform_staging_kp"
    staging = "aws_project_terraform_staging_kp"
    production = "aws_project_terraform_production_kp"
  }
  keyPairName = "${lookup(local.keyPairName_env, local.env)}"

  asgDesired_env = {
    default = "1"
    staging = "1"
    production = "2"
  }
  asgDesired = "${lookup(local.asgDesired_env, local.env)}"

  asgMin_env = {
    default = "1"
    staging = "1"
    production = "2"
  }
  asgMin = "${lookup(local.asgMin_env, local.env)}"

  asgMax_env = {
    default = "2"
    staging = "2"
    production = "4"
  }
  asgMax = "${lookup(local.asgMax_env, local.env)}"
}

  
  

resource "aws_launch_configuration" "sampleApp_lc" {
  name          = "sample_lc_${module.shared_vars.env_suffix}"
  image_id      = local.amiID
  instance_type = "${local.instanceType}"
  key_name = "${local.keyPairName}"
  user_data = "${file("assets/userdata.txt")}"
  security_groups = ["${var.privateSG_ID}"]
}

resource "aws_autoscaling_group" "sampleApp_asg" {
  name                 = "sampleApp_asg_${module.shared_vars.env_suffix}"
  max_size             = "${local.asgMax}"
  min_size             = "${local.asgMin}"
  desired_capacity     = "${local.asgDesired}"
  launch_configuration = aws_launch_configuration.sampleApp_lc.name
  vpc_zone_identifier  = [module.shared_vars.publicSubnetID1]
  target_group_arns    = ["${var.tg_arn}"]

  tags = [
  {
        key                 = "Name"
        value               = "My SampleApp_${module.shared_vars.env_suffix}"
        propagate_at_launch = true
      },
      {
        key                 = "Environment"
        value               = "My SampleApp_${module.shared_vars.env_suffix}"
        propagate_at_launch = true
      }
    ]
}