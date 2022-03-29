############################################################
# common variables
############################################################
variable "env" {
  type        = string
  description = "The environment to deploy to infrastructure"
}

variable "region" {
  type        = string
  description = "The region to deploy to infrastructure"
}

############################################################
# vpc variables
############################################################
variable "vpc" {
  type = object({
    name               = string
    cidr               = string
    availability_zones = list(string)
    private_subnet = object({
      cidrs = list(string)
    })
    public_subnet = object({
      cidrs = list(string)
    })
  })
  description = <<EOT
The VPC configuration to deploy to infrastructure.
  - name: The name of the VPC (string)
  - cidr: The CIDR block of the VPC (string)
  - availability_zones: The availability zones of the VPC (list of strings)
  - private_subnet_cidrs: The CIDR blocks of the private subnets
    - cidrs: The CIDR blocks of the private subnets (list of strings)
  - public_subnet_cidrs: The CIDR blocks of the public subnets
    - cidrs: The CIDR blocks of the public subnets (list of strings)
EOT
}

############################################################
# bastion variables
############################################################
variable "bastion" {
  type = object({
    name              = string
    key_name          = string
    public_key        = string
    ami               = string
    instance_type     = string
    enable_monitoring = bool
  })

  description = <<EOT
The bastion configuration to deploy to infrastructure.
  - name: The name of the bastion (string)
  - key_name: The name of the key pair to use for the bastion instance (string)
  - public_key: The public key to use for the bastion instance (string)
  - ami: The AMI to use for the bastion instance (string)
  - instance_type: The instance type to use for the bastion instance (string)
  - enable_monitoring: Whether to enable monitoring for the bastion instance (boolean)
EOT

  default = {
    name       = "bastion"
    key_name   = "bastion-key-pair"
    public_key = ""
    # ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-20211129
    ami               = "ami-04505e74c0741db8d"
    instance_type     = "t2.micro"
    enable_monitoring = false
  }
}
