# VPC
variable "region" {
  type = string
}
variable "vpc_cidr_block" {}
#variable "public_subnet" {}
#variable "map_az_subnet" {}

# ELB
variable "name" {}
variable "instance_type" {}
variable "key_pair" {}
variable "image_id" {}

# Jenkins
variable "jenkins_admin_user" {}
variable "jenkins_admin_password" {}
