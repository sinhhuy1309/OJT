resource "aws_eks_cluster" "eks_cluster" {
  name = "${var.name}-eks-cluster"
  role_arn = aws_iam_role.eks_cluster.arn
  version = var.cluster_version
  vpc_config {
    #subnet_ids = flatten([var.vpc.public_subnet, var.vpc.private_subnet])
    subnet_ids = flatten([var.vpc.public_subnet])
    endpoint_private_access = var.cluster_endpoint_private_access
    endpoint_public_access = var.cluster_endpoint_public_access
    public_access_cidrs = var.cluster_endpoint_public_access_cidrs
  }
  enabled_cluster_log_types = ["api", "audit", "authenticator", "controllerManager", "scheduler"]
  depends_on = [
    aws_iam_role_policy_attachment.AmazonEKSClusterPolicy,
    aws_iam_role_policy_attachment.AmazonEKSVPCResourceController,
  ]
}