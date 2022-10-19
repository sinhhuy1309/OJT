variable "name" {
  type = string
}

variable "worker_node_iam_role" {
  type = any
}

variable "node_iam_role_arn" {
  type = any
}

variable "aws_iam_openid_connect_provider_arn" {
  type = any
}

variable "aws_iam_openid_connect_provider_extract_from_arn" {
  type = any
}