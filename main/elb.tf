module "elb" {
  source = "../modules/elb"

  name = var.name
  instance_type = var.instance_type
  sg = module.sg.sg
  vpc = module.networking.vpc
  key_pair = var.key_pair
  image_id = var.image_id
  efs_dns_name = module.efs.efs_dns_name
  efs_mount_target = module.efs.efs_mount_target
}