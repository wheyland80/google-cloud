# Create a Service Account for IAC CI/CD pipelines
resource "google_service_account" "iac_service_account" {
  account_id   = "iac-sa"
  display_name = "IAC CI/CD Pipeline Service Account"
  project      = module.cicd_project.project_id
}

# Assign necessary roles to the CI/CD Service Account
resource "google_project_iam_member" "iac_sa_roles" {
  for_each = toset([
    "roles/cloudbuild.builds.editor",
    "roles/source.reader",
    "roles/iam.serviceAccountUser"
  ])
  project = module.cicd_project.project_id
  role    = each.key
  member  = "serviceAccount:${google_service_account.iac_service_account.email}"
}

# Grant access to Cloud Build Logs bucket to the IAC service account
resource "google_storage_bucket_iam_member" "grant_cloud_build_logs" {
  for_each = toset([
    "roles/storage.admin"
  ])
  
  bucket = google_storage_bucket.cloud_build_logs.name
  role   = each.key
  member = "serviceAccount:${google_service_account.iac_service_account.email}"
}

# Grant access to Terraform State bucket to the IAC service account
resource "google_storage_bucket_iam_member" "grant_terraform_state" {
  for_each = toset([
    "roles/storage.admin"
  ])
  
  bucket = google_storage_bucket.terraform_state.name
  role   = each.key
  member = "serviceAccount:${google_service_account.iac_service_account.email}"
}