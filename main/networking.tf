module "networking" {
  source = "../modules/networking"
  
  name = var.name
  vpc_cidr_block = var.vpc_cidr_block
  #map_az_subnet = var.map_az_subnet
}