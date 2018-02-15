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

data "template_file" "manager_userdata" {
    count = "${var.managers_to_run}"
    template = "${file("${path.module}/user_data.sh")}"

    vars {
      bucket_name = "${var.s3_bucket}"
      index = "${count.index}"
    }

}

resource "aws_instance" "docker-managers" {
  count                       = "${var.managers_to_run}"
  instance_type               = "${var.ec2_instance_type}"
  ami                         = "${data.aws_ami.amazonlinux.id}"
  subnet_id                   = "${var.aws_subnet_id}"
  key_name                    = "${aws_key_pair.playground_key.key_name}"
  vpc_security_group_ids      = ["${var.ec2_security_group}"]
  associate_public_ip_address = true

  user_data                   = "${element(data.template_file.manager_userdata.*.rendered,count.index)}"
  iam_instance_profile = "${var.ec2_instance_profile}"

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
