variable "organisation_id" {
  description = "Google Cloud Organisation ID"
  type        = string
}

variable "billing_account_id" {
  description = "The default billing account ID"
  type        = string
}

variable "github_repo_url" {
  description = "The URL of this github repository"
  type        = string
  default     = "https://github.com/wheyland80/google-cloud"
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

variable "github_owner" {
  description = "The owner of the Google Cloud github repository"
  type        = string
  default     = "wheyland80"
}

variable "github_repo" {
  description = "The Google Cloud github repository"
  type        = string
  default     = "google-cloud"
}

variable "github_branch" {
  description = "The branch of the Google Cloud github repository"
  type        = string
  default     = "main"
}
