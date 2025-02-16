module "ofmi_2024_group" {
  source      = "../modules/group"
  alias       = "ofmi-2024"
  description = "Grupo admin de los problemas de la 4a OFMI"
  members = toset([
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
}
