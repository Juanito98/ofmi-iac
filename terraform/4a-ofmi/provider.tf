terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "6.20.0"
    }
    omegaup = {
      source  = "Juanito98/omegaup"
      version = "0.0.2"
    }
  }
  backend "gcs" {
    bucket = "ofmi-iac"
    prefix = "terraform/4a-ofmi"
  }

}

provider "google" {}

