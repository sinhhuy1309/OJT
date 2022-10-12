module "eks_cluster" {
  source = "../modules/eks_cluster"

  name = var.name
  vpc = module.networking.vpc
}