terraform {
  backend "remote" {
    organization = "gullotti"

    workspaces {
      name = "dev12"
    }
  }
}

