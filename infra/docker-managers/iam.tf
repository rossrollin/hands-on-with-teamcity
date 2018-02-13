resource "aws_iam_instance_profile" "playground" {
  name_prefix = "${var.name_of_the_kid}"
  path        = "/"
  role        = "${aws_iam_role.instance_role.name}"

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_iam_role" "instance_role" {
  name_prefix        = "${var.name_of_the_kid}"
  assume_role_policy = "${data.aws_iam_policy_document.instance_role.json}"

  lifecycle {
    create_before_destroy = true
  }
}

data "aws_iam_policy_document" "instance_role" {
  statement {
    effect  = "Allow"
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }
  }
}

resource "aws_iam_role_policy" "auto_discover_cluster" {
  name   = "auto-discover-cluster"
  role   = "${aws_iam_role.instance_role.id}"
  policy = "${data.aws_iam_policy_document.auto_discover_cluster.json}"
}

data "aws_iam_policy_document" "auto_discover_cluster" {
  statement {
    effect = "Allow"

    actions = [
      "ec2:DescribeInstances",
      "ec2:DescribeTags",
      "autoscaling:DescribeAutoScalingGroups",
    ]

    resources = ["*"]
  }
}
