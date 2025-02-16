variable "alias" {
  type        = string
  description = "Group alias"
}

variable "description" {
  type        = string
  description = "A description for the group"
}

variable "members" {
  type        = set(string)
  description = "All the members of the group."
}
