variable "foundation_folder_id" {
  description = "The ID of the Foundation folder"
  type        = string
}

variable "billing_account_id" {
  description = "The default billing account ID"
  type        = string
}

variable "workload_name" {
  description = "The display name for the workload"
  type        = string

  validation {
    condition     = can(regex("^[a-zA-Z0-9 ]{3,20}$", var.workload_name))
    error_message = "The workload name must be between 3 and 20 characters, consist of Alpha-numeric characters and spaces."
  }
}

variable "workload_id" {
  description = "The id for the workload. A short lowercase 2-8 alpha-numeric character workload identifier"
  type        = string

  validation {
    condition     = can(regex("^[a-z0-9]{2,8}$", var.workload_id))
    error_message = "The workload ID must be lowercase, alphanumeric, and between 2 and 8 characters (no spaces or special characters)."
  }
}

