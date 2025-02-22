terraform {
  required_version = ">= 1.7.1"

  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 6.0.0"
    }
  }
}

provider "google" {
  region = var.region
}