module "bastion_key_pair" {
  source  = "terraform-aws-modules/key-pair/aws"
  version = "v1.0.1"

  key_name   = var.bastion.key_name
  public_key = var.bastion.public_key
}
