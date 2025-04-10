# V2 contains the token for user Juan_Carlos_Sigler_Priego
data "google_secret_manager_secret_version" "omegaup_api_key_juanito" {
  secret  = "OMEGAUP_API_KEY"
  version = 2
}

# V3 contains the token for user ofmi
data "google_secret_manager_secret_version" "omegaup_api_key" {
  secret  = "OMEGAUP_API_KEY"
  version = 3
}
