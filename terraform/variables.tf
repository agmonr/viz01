
variable "aws_region" {
  description = "The AWS region to use during deploy"
  default     = "eu-west-1"
}

variable "jenkins_ami" {
  type = string
  default = "ami-34435ede"
}

variable "jenkins_instance_type" {
  type = string
  default = "a1.medium"
}

variable "jenkins_keyname" {
  type = string
  default = "null"  
}

variable "ami" {
  type = string
  default = "null"
}



variable "web_ami" {
  type = string
  default = "null"
}

variable "web_instance_type" {
  type = string
  default = "a1.medium"
}

variable "web_keyname" {
  type = string
  default = "null"  
}

variable vpc_id {
  type = string
  default  = "null"
}

variable aws_subnet {
  type = string
  default  = "null"
}

variable keypair {
  type = string
  default = "agmonr"
}

