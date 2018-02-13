provider "aws" {
  region     = "${var.aws_region}"
  profile    = "${var.aws_profile}"
  access_key = "${var.aws_access_key}"
  secret_key = "${var.aws_secret_key}"
}

locals {
  owner_name = "${lower(element(split("/",data.aws_caller_identity.myself.arn),1))}"
}

data "aws_caller_identity" "myself" {}
