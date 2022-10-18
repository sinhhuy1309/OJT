resource "aws_iam_policy" "ebs_csi_iam_policy" {
  name        = "${var.name}-AmazonEKS_EBS_CSI_Driver_Policy"
  path        = "/"
  description = "EBS CSI IAM Policy"
  policy = data.http.ebs_csi_iam_policy.body
}

# resource "aws_iam_role" "ebs_csi_iam_role" {
#   name = "${var.name}-ebs-csi-iam-role"

#   assume_role_policy = jsonencode({
#     Version = "2012-10-17"
#     Statement = [
#       {
#         Action = "sts:AssumeRoleWithWebIdentity"
#         Effect = "Allow"
#         Sid    = ""
#         Principal = {
#           Federated = "${data.terraform_remote_state.eks.outputs.aws_iam_openid_connect_provider_arn}"
#         }
#         Condition = {
#           StringEquals = {            
#             "${data.terraform_remote_state.eks.outputs.aws_iam_openid_connect_provider_extract_from_arn}:sub": "system:serviceaccount:kube-system:ebs-csi-controller-sa"
#           }
#         }        

#       },
#     ]
#   })

#   tags = {
#     tag-key = "${var.name}-ebs-csi-iam-role"
#   }
# }

resource "aws_iam_role_policy_attachment" "ebs_csi_iam_role_policy_attach" {
  policy_arn = aws_iam_policy.ebs_csi_iam_policy.arn 
  role       = var.worker_node_iam_role
}
