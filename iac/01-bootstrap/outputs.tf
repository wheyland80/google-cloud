output "bootstrap_folder_id" {
  description = "The ID of the Bootstrap folder"
  value       = google_folder.bootstrap_folder.name
}
output "foundation_folder_id" {
  description = "The ID of the Foundation folder"
  value       = google_folder.foundation_folder.name
}
output "cicd_project_id" {
  description = "CI/CD Project ID"
  value       = module.cicd_project.project_id
}