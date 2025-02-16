terraform {
  backend "s3" {
    bucket = "ofmi-iac"
    key    = "4a-ofmi/terraform.tfstate"
    region = "us-east-2"
  }
}
