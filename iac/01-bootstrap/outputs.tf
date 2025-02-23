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
output "cloud_build_logs_bucket_id" {
  description = "Cloud Build Logs Bucket"
  value = google_storage_bucket.cloud_build_logs.id
}
output "terraform_state_bucket_id" {
  description = "OpenTofu State Bucket"
  value = google_storage_bucket.terraform_state.id
}
output "iac_service_account_id" {
  description = "IAC service account ID"
  value = google_service_account.iac_service_account.id
}