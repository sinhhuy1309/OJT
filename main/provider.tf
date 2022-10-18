provider "aws" {
  region = var.region
}

provider "http" {}

provider "helm" {
  kubernetes {
    host = module.eks_cluster.eks.endpoint
    cluster_ca_certificate = base64decode(module.eks_cluster.eks.certificate_authority)
    exec {
      api_version = "client.authentication.k8s.io/v1beta1"
      args        = ["eks", "get-token", "--cluster-name", "${var.name}-eks-cluster"]
      command     = "aws"
    }
  }
}
