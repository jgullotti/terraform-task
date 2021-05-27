
module "networking" {
  source          = "./networking"
  vpc_cidr        = local.vpc_cidr
  access_ip       = var.access_ip
  security_groups = local.security_groups
  subnet_count    = 3
  max_subnets     = 10
  subnet_cidrs    = [for i in range(2, 255, 2) : cidrsubnet(local.vpc_cidr, 8, i)]
}

module "compute" {
  source        = "./compute"
  public_sg     = module.networking.public_sg
  subnets       = module.networking.acme_subnets
  instance_type = "t3.micro"
  vol_size      = 10
}
