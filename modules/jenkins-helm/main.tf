resource "helm_release" "jenkins" {
  depends_on = [var.eks_cluster]
  name       = "jenkins"
  chart      = "${path.module}/jenkins"
}