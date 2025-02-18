resource "google_secret_manager_secret" "omegaup_api_key" {
  secret_id = "OMEGAUP_API_KEY"

  replication {
    user_managed {
      replicas {
        location = var.gcp_region
      }
    }
  }
}
