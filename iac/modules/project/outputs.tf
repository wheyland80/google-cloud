output "project_id" {
  description = "The project ID for the created project"
  value       = google_project.project.project_id
}

output "number" {
  description = "The project number for the created project"
  value       = google_project.project.number
}

output "services" {
  description = "The enabled services for the project"
  value       = var.services
}