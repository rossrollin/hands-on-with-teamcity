data "aws_ami" "amazonlinux" {
  most_recent = true
  owners      = ["137112412989"]

  filter {
    name   = "name"
    values = ["amzn-ami-hvm-*"]
  }

  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }
}

resource "aws_instance" "docker-managers" {
  count                       = "${var.managers_to_run}"
  instance_type               = "${var.ec2_instance_type}"
  ami                         = "${data.aws_ami.amazonlinux.id}"
  subnet_id                   = "${var.aws_subnet_id}"
  key_name                    = "${aws_key_pair.playground_key.key_name}"
  vpc_security_group_ids      = ["${aws_security_group.docker_ports.id}"]
  associate_public_ip_address = true

  #    user_data                   = "${data.template_file.rendered}"
  iam_instance_profile = "${aws_iam_instance_profile.playground.name}"

  tags {
    Name        = "pg-dckr-mgr-${count.index + 1}/${var.managers_to_run}"
    Owner       = "${var.owner_name}"
    Environment = "${var.name_of_the_kid}"
  }

  volume_tags {
    Name        = "pg-dckr-mgr-${count.index + 1}-vol"
    Owner       = "${var.owner_name}"
    Environment = "${var.name_of_the_kid}"
  }
}

resource "aws_key_pair" "playground_key" {
  key_name   = "${var.name_of_the_kid}-key"
  public_key = "${file("~/.ssh/playgroundkey.pub")}"
}
