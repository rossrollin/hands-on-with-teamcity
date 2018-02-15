variable "managers_to_run" {
  default = 3
}

variable "ec2_instance_type" {
  default = "t2.large"
}

variable "ec2_instance_profile" {}

variable "aws_vpc_id" {}
variable "aws_subnet_id" {}
variable "name_of_the_kid" {}
variable "owner_name" {}
variable "s3_bucket" {}
variable "ec2_security_group" {}