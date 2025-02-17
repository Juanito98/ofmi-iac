output "contest_identities_gcs_link" {
  value       = module.contest_identities.passwords_gcs_link
  description = "A url reference to the gcs file of the generated passwords."
}
