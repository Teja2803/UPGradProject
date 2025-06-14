aws_region = "ap-south-1"
env        = "dev"
vpc_cidr   = "10.0.0.0/16"

public_subnets = [
  { cidr = "10.0.1.0/24", az = "ap-south-1a" },
  { cidr = "10.0.2.0/24", az = "ap-south-1b" }
]

private_subnets = [
  { cidr = "10.0.3.0/24", az = "ap-south-1a" },
  { cidr = "10.0.4.0/24", az = "ap-south-1b" }
]
