resource "google_storage_bucket" "gcs_bucket" {
  name                        = "4a-ofmi"
  location                    = var.gcp_location
  project                     = var.gcp_project
  storage_class               = "STANDARD"
  uniform_bucket_level_access = true
}

resource "google_storage_bucket_iam_member" "gcs_bucket_viewers" {
  bucket = google_storage_bucket.gcs_bucket.name
  role   = "roles/storage.objectViewer"
  member = "group:ofmi-core@omegaup.com"
}
