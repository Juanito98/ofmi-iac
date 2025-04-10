resource "omegaup_group" "ofmi_2024" {
  alias       = "ofmi-2024"
  description = "Grupo admin de los problemas de la 4a OFMI"
  provider    = omegaup.omegaup_juanito
}

resource "omegaup_group_member" "ofmi_2024_members" {
  for_each = toset([
    "Angeltapia",
    "EfrenGonzalez",
    "FernandoMauro",
    "Focil",
    "InesLlergo",
    "Janque",
    "Josetapia",
    "Juan_Carlos_Sigler_Priego",
    "Yosshua",
    "alo_54",
    "andreasantillana",
    "charlyhlms",
    "elissabjg",
    "ethanjimenez",
    "freddy",
    "lorena_10",
    "nbreakable",
    "ofmi",
    "omibc"
  ])

  group_alias = omegaup_group.ofmi_2024.alias
  username    = each.value
  provider    = omegaup.omegaup_juanito
}

# Identities
module "ofmi_2024_identities" {
  source = "../modules/identities"

  group_alias    = omegaup_group.ofmi_2024.alias
  identities_csv = file(var._4a_ofmi_identities_filepath)

  gcs_bucket          = google_storage_bucket.gcs_bucket.name
  gcs_output_filename = "identities.csv"
  seed                = var._4a_ofmi_passwords_seed
  providers = {
    "omegaup" = omegaup.omegaup_juanito
  }
}
