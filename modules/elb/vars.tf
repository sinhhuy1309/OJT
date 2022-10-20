variable "name" {
  type = string
}

variable "instance_type" {
  type = string
}

variable "sg" {
  type = any
}

variable "vpc" {
  type = any
}

variable "key_pair" {
  type = string
}

variable "image_id" {
  type = string
}
