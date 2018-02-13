module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "1.9.1"

  name = "${var.name_of_the_kid}"

  cidr = "10.0.0.0/16"

  azs            = ["eu-west-2a"]
  public_subnets = ["10.0.101.0/24"]

  tags {
    Owner       = "${local.owner_name}"
    Environment = "${var.name_of_the_kid}"
  }
}
