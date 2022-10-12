resource "aws_eks_cluster" "eks_cluster" {
  name = "${var.name}-eks-cluster"
  role_arn = aws_iam_role.eks_cluster.arn
  version = 1.23
  vpc_config {
    subnet_ids = flatten([var.vpc.public_subnet, var.vpc.private_subnet])
    endpoint_private_access = true
    endpoint_public_access = true
    public_access_cidrs = ["0.0.0.0/0"]
  }
  depends_on = [
    aws_iam_role_policy_attachment.AmazonEKSClusterPolicy
  ]
}