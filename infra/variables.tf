variable "aws_region" {
  default = ""
}

variable "aws_profile" {
  default = ""
}

variable "aws_access_key" {
  default = ""
}

variable "aws_secret_key" {
  default = ""
}

variable "name_of_the_kid" {}

variable "azs" {
  type = "list"
}

variable "public_subnets" {
  type = "list"
}
