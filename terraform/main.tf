module "networking" {
  source          = "./networking"
  vpc_cidr        = local.vpc_cidr
  access_ip       = var.access_ip
  security_groups = local.security_groups
  subnet_count    = 2
  max_subnets     = 10
  subnet_cidrs    = [for i in range(2, 255, 2) : cidrsubnet(local.vpc_cidr, 8, i)]
}

module "compute" {
  source        = "./compute"
  public_sg     = module.networking.public_sg
  subnets       = module.networking.acme_subnets
  instances     = local.instances
  key_name      = "tempkey"
  pubkey_path   = var.pubkey_path
  instance_type = "t2.micro"
  vol_size      = 10
}
