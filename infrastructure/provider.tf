provider "aws" {
    region = "${var.aws_region}"
}

data "aws_caller_identity" "current_user" {}

provider "random" {}

resource "random_integer" "animal_offset" {
  min     = 0
  max     = 300
}