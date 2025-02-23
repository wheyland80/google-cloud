terraform {
  required_version = ">= 1.9.0"

  required_providers {
    google = {
      source  = "hashicorp/google"
      version = ">= 6.0.0"
    }
    google-beta = {
      source  = "hashicorp/google-beta"
      version = ">= 6.0.0"
    }
    random = {
      source  = "hashicorp/random"
      version = ">= 3.0.0"
    }
  }
}

provider "google" {
  region = var.region
}

provider "google-beta" {
  region = var.region
}

provider "random" {
}