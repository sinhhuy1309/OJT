terraform {
  # backend "s3" {
  #   bucket = "huyls-tf-state"
  #   key = "tf-state"
  #   region = "ap-east-1"
  #   encrypt = true
  #   role_arn = "arn:aws:iam::541253215789:role/HuylsS3BackendRole"
  #   dynamodb_table = "huyls-s3-backend"
  # }
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "~> 3.70"
     }
    helm = {
      source = "hashicorp/helm"
      #version = "2.4.1"
      version = "~> 2.4"
    }
    http = {
      source = "hashicorp/http"
      #version = "2.1.0"
      version = "~> 2.1"
    }
  }
}