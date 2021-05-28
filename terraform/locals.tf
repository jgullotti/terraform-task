locals {
  vpc_cidr = "10.42.0.0/16"
}


locals {
  security_groups = {
    public = {
      name        = "public_sg"
      description = "Security group for public access"
      ingress = {
        ssh = {
          from        = 22
          to          = 22
          protocol    = "tcp"
          cidr_blocks = concat([var.access_ip], [for s in module.networking.acme_subnets : s.cidr_block])
        },
        http = {
          from        = 80
          to          = 80
          protocol    = "tcp"
          cidr_blocks = [for s in module.networking.acme_subnets : s.cidr_block]
        },
        https = {
          from        = 443
          to          = 443
          protocol    = "tcp"
          cidr_blocks = [for s in module.networking.acme_subnets : s.cidr_block]
        }
      }
    }
  }
}
