# V2 contains the token for user Juan_Carlos_Sigler_Priego
# every resource for omegaUp will be created on that account
data "google_secret_manager_secret_version" "omegaup_api_key" {
  secret  = "OMEGAUP_API_KEY"
  version = 2
}
