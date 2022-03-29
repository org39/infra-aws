terraform {
  cloud {
    organization = "org39"

    workspaces {
      name = "infra-aws"
    }
  }
}
