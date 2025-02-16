resource "omegaup_group" "group" {
  alias       = var.alias
  description = var.description
}

resource "omegaup_group_member" "members" {
  for_each    = var.members
  group_alias = var.alias
  username    = each.key
  depends_on  = [omegaup_group.group]

}
