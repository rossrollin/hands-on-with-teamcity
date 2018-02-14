module "docker-managers" {
  source               = "docker-managers"
  name_of_the_kid      = "${var.name_of_the_kid}"
  owner_name           = "${local.owner_name}"
  aws_vpc_id           = "${module.vpc.vpc_id}"
  aws_subnet_id        = "${module.vpc.public_subnets[0]}"
  ec2_instance_profile = "${aws_iam_instance_profile.playground.name}"
  s3_bucket            = "${aws_s3_bucket.docker_join_tokens.id}"
}
