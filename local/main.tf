module "infra" {
  source = "../"

  # common variables
  env    = "local"
  region = "ap-northeast-1"

  # vpc variables
  vpc = {
    name               = "org39",
    cidr               = "10.0.0.0/16",
    availability_zones = ["ap-northeast-1a", "ap-northeast-1c", "ap-northeast-1d"],
    private_subnet = {
      cidrs = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"],
    }
    public_subnet = {
      cidrs = ["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"]
    }
  }

  # bastion variables
  bastion = {
    name              = "org39-bastion"
    create            = true
    key_name          = "org39-bastion-key-pair"
    public_key        = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDcB1+beAgQR2f33yRIHgYgPvwZBmMrmweyT4nusuDxc9LWAw9moftVMIYlmD1ulwG/KoqGfsF2kpzMGVKP4qCyf00m0qSqVLAwyl85c2QZFMMRBjqg+OLr/hrLHcSNFyKoTPofUkZ1HzHJItlQB+FszsSkBGVqEgPFLSoN+YJ0jeQUrzVRKctg0MfEA9f58PTEdCNHHURu6q1q4hUKrIq7N9NYwsWehfoOwBfyC5Xyp7d3+GILb8wwAKp18ZMY3vTA4NeW7d7WdpHpYaWsm42vEAsYEmRJlL9vV6ZRL+Zk2p2qdLVnWH2Jy5qIhNdrHeTTq+JUvYwNm0gAxSGQ/uLj"
    ami               = "ami-8104a4f8"
    instance_type     = "t2.micro"
    enable_monitoring = false
  }
}
