locals {
  identities_csv = csvdecode(var.identities_csv)
}

resource "random_password" "passwords" {
  for_each = toset([for identity in local.identities_csv : identity.username])

  keepers = {
    # Generate a new id each time we switch to a new AMI id
    seed = var.seed
  }

  length           = 12
  override_special = "@#-!"
}

resource "google_storage_bucket_object" "gcs_identities" {
  bucket = var.gcs_bucket
  name   = var.gcs_output_filename
  content = join("\n", concat(
    ["username,password"], # CSV Header
    [for identity in local.identities_csv : "${identity.username},${random_password.passwords[identity.username].result}"]
  ))
  depends_on = [random_password.passwords]
}
