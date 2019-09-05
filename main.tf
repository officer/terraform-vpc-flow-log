locals {
  cloudwatch_enabled = "${var.type == "cloudwatch" ? true : false}"
  s3_enabled = "${var.type == "s3" ? true : false}"
}


resource "aws_flow_log" "flow_log" {
  vpc_id = "${var.vpc_id}"
  traffic_type = "${var.log_type}"
  iam_role_arn = "${local.cloudwatch_enabled ? aws_iam_role.flow_log_role.0.arn : ""}"
  log_destination = "${local.cloudwatch_enabled ? aws_cloudwatch_log_group.flow_log.0.arn : var.log_bucket.arn }"
  log_destination_type = "${local.cloudwatch_enabled ? "cloud-watch-logs" : "s3"}"
}

# Flow log configuration for CW Logs
resource "aws_cloudwatch_log_group" "flow_log" {
  count = "${local.cloudwatch_enabled ? 1 : 0}"
  name_prefix = "${var.namespace}-"

}

resource "aws_iam_role" "flow_log_role" {
  count = "${local.cloudwatch_enabled ? 1 : 0}"
  name_prefix = "${var.namespace}-"
  assume_role_policy = "${data.aws_iam_policy_document.FlowLogAssumePolicy.json}"
}

resource "aws_iam_policy" "flow_log_policy" {
  count = "${local.cloudwatch_enabled ? 1 : 0}"
  name_prefix = "${var.namespace}-"
  policy = "${data.aws_iam_policy_document.FlowLogCWPolicy.json}"
}

resource "aws_iam_role_policy_attachment" "role" {
  count = "${local.cloudwatch_enabled ? 1 : 0}"
  policy_arn = "${aws_iam_policy.flow_log_policy.0.arn}"
  role = "${aws_iam_role.flow_log_role.0.name}"
}

# Flow log configuration for S3
resource "aws_s3_bucket_policy" "flow_log_bucket_policy" {
  count  = "${local.s3_enabled ? 1 : 0}"
  bucket = "${var.log_bucket.id}"
  policy = "${data.aws_iam_policy_document.FlowLogS3BucketPolicy.json}"
}

