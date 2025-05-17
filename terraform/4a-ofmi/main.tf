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
    "SJMA_11723",
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
    omegaup = omegaup.omegaup_juanito
  }
}

# Identidades del Selectivo 1

resource "omegaup_group" "selectivo_1" {
  alias       = "4AOFMISEL1"
  name        = "4a OFMI Selectivo 1"
  description = "Preselectivo de la 4a OFMI"
}

module "selectivo_1_identities" {
  source = "../modules/identities"

  group_alias    = omegaup_group.selectivo_1.alias
  identities_csv = file("files/identities_selectivo.generated.csv")

  gcs_bucket          = google_storage_bucket.gcs_bucket.name
  gcs_output_filename = "identities_selectivo.csv"
  seed                = var._4a_ofmi_passwords_seed
}
