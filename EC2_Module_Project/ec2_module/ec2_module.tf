variable "vpcid" {
	type = string
	default = "vpc-040333ad398d57722"
}

resource "aws_security_group" "terraform_ec2_sg_module" {
  name        = "terraform_ec2_sg_module"
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

variable "amiID" {
	default = "ami-0bf84c42e04519c85"
}

resource "aws_instance" "terraform_ec2_instance" {
  ami           = "${var.amiID}"
  instance_type = "t3.micro"
  key_name = "Terraform-key-pair-test"
  vpc_security_group_ids =["${aws_security_group.terraform_ec2_sg_module.id}"]

  tags = {
    Name = "Terraform EC2 Instance"
  }
 }