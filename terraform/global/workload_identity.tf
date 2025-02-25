locals {
  gh_repo = "Juanito98/ofmi-iac"
}

# Create the service account for that GitHub actions will assume
resource "google_service_account" "ofmi_iac_sa" {
  account_id = "ofmi-iac"
}

# Give enough permissions 
resource "google_project_iam_member" "ofmi_iac_sa_permission" {
  for_each = toset([
    "roles/editor",
    "roles/storage.admin",
    "roles/resourcemanager.projectIamAdmin",
    "roles/secretmanager.admin",
  ])

  project = var.gcp_project
  member  = "serviceAccount:${google_service_account.ofmi_iac_sa.email}"
  role    = each.key

}

# Using workload identity pool to allow GitHub actions authenticate to google provider
resource "google_iam_workload_identity_pool" "workload_identity_pool" {
  workload_identity_pool_id = "pool"
  display_name              = "Production Identity Pool"
  disabled                  = false
}


resource "google_iam_workload_identity_pool_provider" "github_pool_provider" {
  workload_identity_pool_id          = "pool"
  workload_identity_pool_provider_id = "github-provider"
  display_name                       = "GitHub Actions"
  description                        = "GitHub Actions identity pool provider for automated test"
  disabled                           = false
  attribute_condition                = <<EOT
    attribute.repository == "${local.gh_repo}"
EOT
  attribute_mapping = {
    "google.subject"       = "assertion.sub"
    "attribute.actor"      = "assertion.actor"
    "attribute.aud"        = "assertion.aud"
    "attribute.repository" = "assertion.repository"
  }
  oidc {
    issuer_uri = "https://token.actions.githubusercontent.com"
  }
}

# Give access to this repo Juanito98/ofmi-iac
resource "google_service_account_iam_binding" "github_actions_principal_set" {
  service_account_id = google_service_account.ofmi_iac_sa.name
  role               = "roles/iam.workloadIdentityUser"
  members            = ["principalSet://iam.googleapis.com/${google_iam_workload_identity_pool.workload_identity_pool.name}/attribute.repository/${local.gh_repo}"]
}
