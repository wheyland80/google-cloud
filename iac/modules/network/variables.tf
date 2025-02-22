variable "resource_prefix" {
  description = "Prefix for resource names"
  type        = string
}

variable "resource_suffix" {
  description = "Suffix for resource names"
  type        = string
}

variable "resource_code" {
  description = "Code for resource name"
  type        = string
}

variable "environment_code" {
  description = "Environment code (e.g., dev, prod)"
  type        = string
}

variable "region" {
  description = "Region for the subnets and router"
  type        = string
}

variable "project_id" {
  description = "Project ID of the VPC network"
  type        = string
}

# variable "shared_vpc_project_id" {
#   description = "Project ID of the shared VPC project"
#   type        = string
# }

# variable "service_project_ids" {
#   description = "List of project IDs for service projects to connect to the shared VPC"
#   type        = map(string)
# }

variable "subnets" {
  description = "List of subnet configurations"
  type = list(object({
    name          = string
    ip_cidr_range = string
    region        = string
  }))
}