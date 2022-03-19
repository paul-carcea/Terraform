variable "amiID" {
	default = "ami-0bf84c42e04519c85"
}

variable "sg_id" {}
variable "ec2_name" {}

resource "aws_instance" "terraform_ec2_instance" {
  ami           = "${var.amiID}"
  instance_type = "t3.micro"
  key_name = "Terraform-key-pair-test"
  vpc_security_group_ids =["${var.sg_id}"]

  tags = {
    Name = "${var.ec2_name}"
  }
 }