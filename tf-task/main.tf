terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "4.51.0"
    }
  }
}

provider "google" {
  region = var.region
  zone   = var.zone
}

module "network" {
  source = "./network"
}

module "compute" {
  source = "./compute"

  vpc_name = module.network.vpc_name
  subnet_name = module.network.subnet_name
}


