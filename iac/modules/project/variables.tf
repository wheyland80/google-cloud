variable "name" {
  description = "The display name for the project"
  type        = string
}

variable "project_id" {
  description = "The project ID"
  type        = string
}

variable "folder_id" {
  description = "The folder ID where the project will be created"
  type        = string
}

variable "billing_account_id" {
  description = "The billing account ID associated with the project"
  type        = string
}

variable "services" {
  description = "A list of Google Cloud services to enable in the project"
  type        = list(string)
}
