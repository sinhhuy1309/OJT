module "ebs" {
  source = "../modules/ebs"

  name = var.name
  worker_node_iam_role = module.eks_cluster.eks.worker_node_iam_role
  node_iam_role_arn = module.eks_cluster.eks.node_iam_role_arn
  aws_iam_openid_connect_provider_arn = module.iam_oidc.aws_iam_openid_connect_provider_arn
  aws_iam_openid_connect_provider_extract_from_arn = module.iam_oidc.aws_iam_openid_connect_provider_extract_from_arn
}