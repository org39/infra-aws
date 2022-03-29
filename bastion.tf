module "bastion_key_pair" {
  source  = "terraform-aws-modules/key-pair/aws"
  version = "v1.0.1"

  key_name   = var.bastion.key_name
  public_key = var.bastion.public_key

  tags = {
    Name = var.bastion.key_name
    Role = "bastion"
  }
}

module "bastion_security_group" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "4.9.0"

  name        = var.bastion.name
  description = "Security group for bastion instance"
  vpc_id      = module.vpc.vpc_id

  ingress_cidr_blocks = ["0.0.0.0/0"]
  ingress_rules       = ["ssh-tcp", "all-icmp"]
  egress_rules        = ["all-all"]

  depends_on = [module.vpc]

  tags = {
    Name = var.bastion.name
    Role = "bastion"
  }
}

module "bastion" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "v3.5.0"

  name = var.bastion.name

  ami                     = var.bastion.ami
  instance_type           = var.bastion.instance_type
  key_name                = var.bastion.key_name
  monitoring              = var.bastion.enable_monitoring
  vpc_security_group_ids  = [module.bastion_security_group.security_group_id]
  subnet_id               = module.vpc.public_subnets.0
  ebs_optimized           = true
  enable_volume_tags      = true
  disable_api_termination = true
  root_block_device = [
    {
      encrypted   = true
      volume_type = "gp2"
      volume_size = 32
    },
  ]

  depends_on = [module.bastion_key_pair, module.bastion_security_group]

  tags = {
    Name = var.bastion.name
    Role = "bastion"
  }

}
