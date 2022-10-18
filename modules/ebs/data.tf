data "http" "ebs_csi_iam_policy" {
  url = "https://raw.githubusercontent.com/kubernetes-sigs/aws-ebs-csi-driver/master/docs/example-iam-policy.json"
  request_headers = {
    Accept = "application/json"
  }
}

# output "ebs_csi_iam_policy" {
#   value = data.http.ebs_csi_iam_policy.body
# }

data "terraform_remote_state" "eks" {
  backend = "s3"
  config = {
    bucket = "huyls-tf-state"
    key = "tf-state"
    region = "ap-east-1"
  }
}