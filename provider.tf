provider "aws" {
  profile = "default"
  region  = "eu-west-1"
  version = "~> 2.7"
}

terraform {
  required_version = ">= 0.12.9"

  backend "s3" {
    bucket  = "dm-vpc-states"
    key     = "dm_arci_finale/terraform.tfstate"
    region  = "eu-west-1"
    encrypt = "true"
  }
}


