provider "aws" {
	region = "eu-west-1"
	profile = "PaulCarcea-terraform"
}


//Strings examples
//this is a string variable

variable "firstString" {
	type = string
	default = "this is my first string"
}

variable "multilineString" {
	type = string
	default = <<EOH
	this is my multiline 
	string
	newline
	EOH
}

output "myfirstoutput" {
	value = "${var.firstString}"
}

output "mymultilineoutput" {
	value = "${var.multilineString}"
}


//Maps examples

variable "mapExample" {
	type = map
	default = {
		"useast" = "ami1"
		"uswest" = "ami2"
	}
}

output "mapOutput" {
	value = "${var.mapExample["uswest"]}"
}


//Lists(or arrays) examples

variable "mySecurityGroupList" {
	type = list
	default = ["sg1", "sg2", "sg3"]
}

output "sgOutput" {
	value = "${var.mySecurityGroupList}"
}


//Booleans examples

variable "testBool" {
	default = true
}

output "boolOutput" {
	value = "${var.testBool}"
}


//I/O variables w/ examples

variable "myInputVariable" {
	type = string
}

output "myOutputVariable" {
	sensitive = true
	value = "${var.myInputVariable}"
}
