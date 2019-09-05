# Required
variable "namespace" {
  description = "Namespace for resource a.k.a prefix"
  type = "string"
}

variable "vpc_id" {
  description = "VPC ID"
  type = "string"
}

# Optional
variable "destination_type" {
  description = "Flow Log type. valid value s3, cloudwatch default to cloudwatch"
  type = "string"
  default = "cloudwatch"
}

variable "log_type" {
  description = "Type of logs capturing. valid value ALL, ACCEPT, REJECT default to ALL"
  type        = "string"
  default     = "ALL"
}

variable "log_bucket" {
  description = "(Optional) The terraform s3 bucket object which logs go into. Required if destination_type is s3"
  type        = "map"
  default     = {}
}
