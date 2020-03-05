
variable "aws_region" {
  description = "The AWS region to use during deploy"
  default     = "eu-west-1"
}

variable "jenkins_ami" {
  type = string
  default = "null"
}

variable "jenkins_instance_type" {
  type = string
  default = "a1.medium"
}

variable "jenkins_keyname" {
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
