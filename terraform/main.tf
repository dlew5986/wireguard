terraform {
  backend "s3" {
    bucket         = "terraform-state-wireguard"
    dynamodb_table = "terraform-state-wireguard-locks"
    encrypt        = true
    key            = "wireguard/terraform.tfstate"
    region         = "us-east-2"
  }
}

provider "aws" {
  profile = "default"
  region  = "us-east-2"

  default_tags {
    tags = local.default_tags
  }
}

data "aws_ami" "source_ami" {
  most_recent = true
  owners      = ["self"]
  filter {
    name   = "name"
    values = [local.ami_regex]
  }
}

data "aws_key_pair" "wireguard" {
  key_name = local.key_pair_name
}

data "aws_vpc" "vpc_default" {
  default = true
}
