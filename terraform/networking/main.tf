data "aws_availability_zones" "available" {}

resource "random_shuffle" "az_names" {
  input        = data.aws_availability_zones.available.names
  result_count = var.max_subnets
}

resource "aws_vpc" "acme_vpc" {
  cidr_block           = var.vpc_cidr
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name = "acme-vpc"
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_subnet" "acme_subnet" {
  count                   = var.subnet_count
  vpc_id                  = aws_vpc.acme_vpc.id
  cidr_block              = var.subnet_cidrs[count.index]
  map_public_ip_on_launch = true
  availability_zone       = random_shuffle.az_names.result[count.index]

  tags = {
    Name = "subnet_${count.index + 1}"
  }
}

resource "aws_route_table_association" "rt_public_assoc" {
  count          = var.subnet_count
  subnet_id      = aws_subnet.acme_subnet.*.id[count.index]
  route_table_id = aws_route_table.acme_route_table.id
}

resource "aws_internet_gateway" "acme_gateway" {
  vpc_id = aws_vpc.acme_vpc.id

  tags = {
    Name = "acme_gateway"
  }

}


resource "aws_route_table" "acme_route_table" {
  vpc_id = aws_vpc.acme_vpc.id
  tags = {
    Name = "acme_public"
  }
}

resource "aws_route" "default_route" {
  route_table_id         = aws_route_table.acme_route_table.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.acme_gateway.id
}

resource "aws_security_group" "acme_sg" {
  for_each    = var.security_groups
  name        = each.value.name
  description = each.value.description
  vpc_id      = aws_vpc.acme_vpc.id

  dynamic "ingress" {
    for_each = each.value.ingress
    content {
      from_port   = ingress.value.from
      to_port     = ingress.value.to
      protocol    = ingress.value.protocol
      cidr_blocks = ingress.value.cidr_blocks
    }

  }


  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}


