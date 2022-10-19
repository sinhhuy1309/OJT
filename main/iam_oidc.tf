module "iam_oidc" {
  source = "../modules/iam_oidc"
  name = var.name
  cluster = module.eks_cluster.eks.cluster
}