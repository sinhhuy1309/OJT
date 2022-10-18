module "eks_cluster" {
  source = "../modules/eks_cluster"

  name = var.name
  vpc = module.networking.vpc
  key_pair = var.key_pair
}

# data "aws_eks_cluster" "eks-cluster" {
#   depends_on = [
#     module.eks_cluster
#   ]
#   name = module.eks_cluster.cluster_name
# }