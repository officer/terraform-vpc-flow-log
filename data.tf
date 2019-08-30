data "aws_iam_policy_document" "FlowLogCWPolicy" {
    statement {
        actions = [
            "logs:CreateLogGroup",
            "logs:CreateLogStream",
            "logs:PutLogEvents",
            "logs:DescribeLogGroups",
            "logs:DescribeLogStreams"
        ]
        effect = "Allow"
        resources = ["*"]
    }
}

data "aws_iam_policy_document" "FlowLogS3BucketPolicy" {
    statement {
        principals {
            type = "Service"
            identifiers = ["delivery.logs.amazonaws.com"]
        }
        actions = [
            "s3:PutObject"
        ]
        effect = "Allow"
        resources = ["${aws_s3_bucket.flow_log_bucket.arn}/*"]
    }

    statement {
        effect = "Allow"
        actions = [
            "s3:GetBucketAcl"
        ]
        resources = ["${aws_s3_bucket.flow_log_bucket.arn}"]
        principals {
            type = "Service"
            identifiers = ["delivery.logs.amazonaws.com"]
        }
        
    }
}

data "aws_iam_policy_document" "FlowLogAssumePolicy" {
  statement {
      effect = "Allow"
      actions = [
          "sts:AssumeRole"
      ]
      principals {
          type = "Service"
          identifiers = ["vpc-flow-logs.amazonaws.com"]
      }
  }
}
