variable "cidr_block" {
    default = "10.0.0.0/16"
    description = "cidr for VPC"
    type = string
}
variable "azs" {
    type = list
    default = ["ap-south-1a", "ap-south-1b"]
    description = "AZs"
}

variable "private_subnets" {
    type = list
    default = ["10.0.1.0/24", "10.0.2.0/24"]
    description = "private subnets"
} 

variable "public_subnets" {
    type = list
    default = ["10.0.101.0/24", "10.0.102.0/24"]
    description = "public subnet"
} 