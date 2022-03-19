variable "vpcid" {
	type = string
	default = "vpc-040333ad398d57722"
}

resource "aws_security_group" "sg_module_creation" {
  name        = "sg_module_creation"
  description = "Terraform tutorial security groups for ec2 instance"
  vpc_id      = var.vpcid

  ingress {
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  egress {
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }
}

output "sg_id_output" {
  value = "${aws_security_group.sg_module_creation.id}"
}