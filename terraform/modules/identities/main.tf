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

resource "omegaup_identities" "identities" {
  group_alias = var.group_alias
  identities = [
    for identity in local.identities_csv :
    {
      username    = "${var.group_alias}:${identity.username}"
      password    = random_password.passwords[identity.username].result
      name        = identity.name
      gender      = identity.gender
      school_name = identity.school_name
      country_id  = identity.country_id
      state_id    = identity.state_id
    }
  ]
}

resource "google_storage_bucket_object" "gcs_identities" {
  bucket = var.gcs_bucket
  name   = var.gcs_output_filename
  content = join("\n", concat(
    ["name,username,full_username,password"], # CSV Header
    [for identity in local.identities_csv : "${idendity.name},${identity.username},${var.group_alias}:${identity.username},${random_password.passwords[identity.username].result}"]
  ))
  depends_on = [omegaup_identities.identities]
}
