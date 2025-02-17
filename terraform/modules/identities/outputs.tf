output "passwords_gcs_link" {
  value       = "https://storage.cloud.google.com/${var.gcs_bucket}/${var.gcs_output_filename}"
  description = "A url reference to the gcs file of the generated passwords."
  depends_on  = [google_storage_bucket_object.gcs_identities]
}
