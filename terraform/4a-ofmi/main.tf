resource "omegaup_group" "ofmi_2024" {
  alias       = "ofmi-2024"
  description = "Grupo admin de los problemas de la 4a OFMI"
}

resource "omegaup_group_member" "ofmi_2024_members" {
  for_each = toset([
    "Angeltapia",
    "EfrenGonzalez",
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
}
