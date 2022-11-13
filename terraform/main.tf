terraform {
  backend "s3" {
    bucket         = "terraform-state-wireguard"
    dynamodb_table = "terraform-state-wireguard-locks"
    encrypt        = true
    key            = "wireguard/terraform.tfstate"
    region         = "us-east-2"
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}

provider "aws" {
  profile = "default"
  region  = "us-east-2"

  default_tags {
    tags = local.tags
  }

}
