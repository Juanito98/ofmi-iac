terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = ">= 6.20.0"
    }
    omegaup = {
      source  = "Juanito98/omegaup"
      version = ">= 0.0.4"
    }
  }
  backend "gcs" {
    bucket = "ofmi-iac"
    prefix = "terraform/4a-ofmi"
  }

}

provider "google" {
  project = var.gcp_project
}

provider "omegaup" {
  alias     = "omegaup_juanito"
  api_token = data.google_secret_manager_secret_version.omegaup_api_key_juanito.secret_data
}


provider "omegaup" {
  api_token = data.google_secret_manager_secret_version.omegaup_api_key.secret_data
}
