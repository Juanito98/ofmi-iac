output "ofmi_2024_identities_gcs_link" {
  value       = module.ofmi_2024_identities.passwords_gcs_link
  description = "A url reference to the gcs file of the generated passwords."
}

output "ofmi_2024_selectivo_1_identities_gcs_link" {
  value       = module.selectivo_1_identities.passwords_gcs_link
  description = "A url reference to the gcs file of the generated passwords."
}
