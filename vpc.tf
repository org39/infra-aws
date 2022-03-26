module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "v3.13.0"

  name = var.vpc.name
  cidr = var.vpc.cidr

  enable_ipv6 = true

  azs             = var.vpc.availability_zones
  private_subnets = var.vpc.private_subnet.cidrs
  public_subnets  = var.vpc.public_subnet.cidrs

  # one single NAT gateway for all subnets
  enable_nat_gateway     = true
  single_nat_gateway     = true
  one_nat_gateway_per_az = false

  vpc_tags = {
    Name = var.vpc.name
  }
}
