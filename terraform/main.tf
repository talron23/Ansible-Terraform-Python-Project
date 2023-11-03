terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "5.21.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}

module "ec2" {
  source      = "./ec2-instance"
  instance_type = "t2.micro"
  instance_name = "webapp"
  # Other input variables
}
