resource "aws_s3_bucket" "docker_join_tokens" {
  acl = "private"
  force_destroy = true

  tags {
    Owner       = "${local.owner_name}"
    Environment = "${var.name_of_the_kid}"
  }
}

resource "aws_s3_bucket_policy" "docker_join_tokens" {
  bucket = "${aws_s3_bucket.docker_join_tokens.id}"

  policy = <<POLICY
{
  "Id": "Policy1518602190622",
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "Stmt1518602189199",
      "Action": [
        "s3:PutObject",
        "s3:GetObject",
        "s3:ListBucket"
      ],
      "Effect": "Allow",
      "Resource": [
          "${aws_s3_bucket.docker_join_tokens.arn}/*",
          "${aws_s3_bucket.docker_join_tokens.arn}"
      ],
      "Principal": {
        "AWS": [
          "${aws_iam_role.instance_role.arn}"
        ]
      }
    }
  ]
}
POLICY
}
