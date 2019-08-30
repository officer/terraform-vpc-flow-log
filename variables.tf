variable "region" {
  description = "Region"
  type = "string"
}


variable "vpc_id" {
  description = "VPC ID"
  type = "string"
}

variable "type" {
  description = "Flow Log type valid type is s3/cloudwatch default -> cloudwatch"
  type = "string"
  default = "cloudwatch"
}

variable "namespace" {
  description = "Namespace for resource a.k.a prefix"
  type = "string"
}
