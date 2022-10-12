module "sg" {
  source = "../modules/sg"

  name = var.name
  vpc = module.networking.vpc
}