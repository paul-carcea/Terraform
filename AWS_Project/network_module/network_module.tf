
module "shared_vars" {
  source = "../shared_vars"
}

resource "aws_security_group" "publicSG" {
  name        = "publicSG_${module.shared_vars.env_suffix}"
  description = "Public Security Group for ELB in ${module.shared_vars.env_suffix}"
  vpc_id      = module.shared_vars.vpcid

  ingress {
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  egress {
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }
}

output "publicSG_ID" {
  value ="${aws_security_group.publicSG.id}"
}

resource "aws_security_group" "privateSG" {
  name        = "privateSG_${module.shared_vars.env_suffix}"
  description = "Private Security Group for EC2 in ${module.shared_vars.env_suffix}"
  vpc_id      = module.shared_vars.vpcid

  ingress {
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    security_groups = ["${aws_security_group.publicSG.id}"]
  }

  egress {
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }
}

output "privateSG_ID" {
  value ="${aws_security_group.privateSG.id}"
}