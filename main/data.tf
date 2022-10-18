# data "aws_eks_cluster" "eks-cluster" {
#   depends_on = [
#     module.eks_cluster
#   ]
#   name = module.eks_cluster.cluster_name
# }