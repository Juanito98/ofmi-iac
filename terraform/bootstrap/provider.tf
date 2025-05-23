terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "6.20.0"
    }
  }

  backend "gcs" {
    bucket = "ofmi-iac"
    prefix = "terraform/bootstrap"
  }
}

provider "google" {}
