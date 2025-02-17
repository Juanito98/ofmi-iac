variable "identities_csv" {
  type        = string
  description = "File content of the identities csv without passwords."
}

variable "seed" {
  type        = string
  description = "Seed to use to generate passwords."
  default     = "seed"
}

variable "gcs_bucket" {
  type        = string
  description = "The GCS bucket to upload the csv output of identities with passwords."
}

variable "gcs_output_filename" {
  type        = string
  description = "The GCS filepath to upload the csv output of identities with passwords."
}
