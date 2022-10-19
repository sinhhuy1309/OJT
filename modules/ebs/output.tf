output "ebs_csi_iam_policy_arn" {
  value = aws_iam_policy.ebs_csi_iam_policy.arn 
}

output "ebs_csi_helm_metadata" {
  value = helm_release.ebs_csi_driver.metadata
}

# output "ebs_csi_iam_role_arn" {
#   value = aws_iam_role.ebs_csi_iam_role.arn
# }