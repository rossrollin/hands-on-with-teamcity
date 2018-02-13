module "docker-managers" {
  source          = "docker-managers"
  name_of_the_kid = "${var.name_of_the_kid}"
  owner_name      = "${local.owner_name}"
  aws_vpc_id      = "${module.vpc.vpc_id}"
  aws_subnet_id   = "${module.vpc.public_subnets[0]}"
}
