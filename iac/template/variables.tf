variable "organisation_id" {
  description = "Google Cloud Organisation ID"
  type        = string
}

variable "root_folder_id" {
  description = "The Projects folder ID"
  type        = string
}

variable "billing_account_id" {
  description = "The default billing account ID"
  type        = string
}

variable "location" {
  description = "The default location for resources"
  type        = string
  default     = "us"
}

variable "region" {
  description = "The default region for resources"
  type        = string
  default     = "us-east1"
}

variable "zone" {
  description = "The default zone for resources"
  type        = string
  default     = "us-east1-c"
}
