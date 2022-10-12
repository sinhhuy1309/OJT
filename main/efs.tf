module "efs" {
  source = "../modules/efs"

  name = var.name
  vpc = module.networking.vpc
  sg = module.sg.sg
}