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

data "template_file" "user_data_user" {
  count = "${var.instances_to_deploy}"
  template = "${file("scripts/user_data_user.sh")}"

  vars {
    hostname = "${var.inst_base_name}-${count.index}"
    count    = "${count.index}" 
    ssh_user = "${var.ssh_user}"
    ssh_pass = "${var.ssh_password}"
  }
}

resource "aws_instance" "user_instances" {
  count                     = "${var.instances_to_deploy}"
  ami                       = "${data.aws_ami.amazonlinux.id}"
  subnet_id                 = "${var.vpc_subnet_id}"
  instance_type             = "${var.instance_type}"
  key_name                  = "${var.key_name}"
  vpc_security_group_ids    = ["${aws_security_group.user_instances.id}"]
  user_data                 = "${element(data.template_file.user_data_user.*.rendered, count.index)}"
  tags {
      Name = "${var.inst_base_name}-${lower(element(var.animals,random_integer.animal_offset.result + count.index))}"
      Owner = "${lower(element(split("/",data.aws_caller_identity.current_user.arn),1))}"
  }
}

resource "aws_security_group" "user_instances" {
  name        = "user_instances_all"
  description = "Allow all traffic for ECS IP"
  vpc_id      = "${var.vpc_id}"


  ingress {
    from_port = 0
    to_port   = 0
    protocol  = "-1"
    self      = true
  }

  ingress {
    from_port = 0
    to_port   = 0
    protocol  = "-1"
    cidr_blocks = ["0.0.0.0/0"]
#    cidr_blocks = ["80.75.69.20/32"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_route53_record" "user_instance" {
  count = "${var.instances_to_deploy}"
  zone_id = "${var.r53_zone_id}"
  name    = "${lower(element(var.animals,random_integer.animal_offset.result + count.index))}"
  type    = "A"
  ttl     = "60"
  records = ["${element(aws_instance.user_instances.*.public_ip,count.index)}"]
}
