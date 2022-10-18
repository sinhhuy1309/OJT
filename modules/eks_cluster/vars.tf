variable "name" {
  type = any
}

variable "vpc" {
  type = any
}

variable "key_pair" {
  type = string
}

variable "cluster_endpoint_private_access" {
  type        = bool
  default     = false
}

variable "cluster_endpoint_public_access" {
  type        = bool
  default     = true
}

variable "cluster_endpoint_public_access_cidrs" {
  type        = list(string)
  default     = ["0.0.0.0/0"]
}

variable "cluster_version" {
  type = string
  default     = null
}