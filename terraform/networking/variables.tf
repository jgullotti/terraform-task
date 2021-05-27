variable "vpc_cidr" {
  type = string
}

variable "subnet_cidrs" {
  type = list(any)
}

variable "subnet_count" {
  type = number
}

variable "max_subnets" {
  type = number
}

variable "access_ip" {
  type = string
}

variable "security_groups" {}
