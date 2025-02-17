resource "google_storage_bucket" "ofmi_iac" {
  name                        = "ofmi-iac"
  location                    = var.gcp_location
  project                     = var.gcp_project
  storage_class               = "STANDARD"
  uniform_bucket_level_access = true
}
