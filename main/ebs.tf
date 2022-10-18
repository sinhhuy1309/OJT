module "ebs" {
  source = "../modules/ebs"

  name = var.name
  worker_node_iam_role = module.eks_cluster.eks.worker_node_iam_role
  node_iam_role_arn = module.eks_cluster.eks.node_iam_role_arn
}