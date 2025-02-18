# Enable gcp services
resource "google_project_service" "project" {
  for_each = toset(["secretmanager.googleapis.com", "iam.googleapis.com"])
  project  = var.gcp_project
  service  = each.key
}

# Allow ofmi-core@omegaup.com to editor access to all resources in GCP.
resource "google_project_iam_member" "gcp_editors" {
  project = var.gcp_project
  role    = "roles/editor"
  member  = "group:ofmi-core@omegaup.com"
}
