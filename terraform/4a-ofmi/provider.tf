terraform {
  required_providers {
    omegaup = {
      source  = "Juanito98/omegaup"
      version = "0.0.2"
    }
  }
  backend "s3" {
    bucket = "ofmi-iac"
    key    = "4a-ofmi/terraform.tfstate"
    region = "us-east-2"
  }
}
