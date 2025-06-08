terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
    }
  }
}
terraform {
  backend "s3" {
    bucket = "teja2803-terraform-bucket"
    key    = "terraform.tfstate"
    region = "ap-south-1"
  }
}
