variable "gcp_location" {
  type    = string
  default = "us-central1"
}

variable "gcp_project" {
  type    = string
  default = "ofmi-web"
}

variable "_4a_ofmi_passwords_seed" {
  type    = string
  default = "seed"
}

variable "_4a_ofmi_identities_filepath" {
  type    = string
  default = "files/identities.csv"
}
