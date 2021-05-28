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

locals {
  instances = {
    server1 = {
      name      = "Server1"
      subnet_id = module.networking.acme_subnets[0].id
    },
    server2 = {
      name      = "Server2"
      subnet_id = module.networking.acme_subnets[1].id
    }
  }
}
