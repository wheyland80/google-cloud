# Create a Service Account for IAC CI/CD pipelines
resource "google_service_account" "iac_service_account" {
  account_id   = "iac-sa"
  display_name = "IAC CI/CD Pipeline Service Account"
  project      = module.cicd_project.project_id
}

# # Grant Org Admin to the IAC Service Account
# resource "google_organization_iam_member" "iac_sa_org_admin" {
#   org_id = var.organisation_id
#   role   = "roles/resourcemanager.folderAdmin"
#   member = "serviceAccount:${google_service_account.iac_service_account.email}"
# }

# Grant CI/CD project permissions to the IAC Service Account
resource "google_project_iam_member" "grant_cicd_project_permissions" {
  for_each = toset([
    "roles/cloudbuild.builds.editor",
    "roles/iam.serviceAccountUser",
    "roles/logging.logWriter",
  ])
  project = module.cicd_project.project_id
  role    = each.key
  member  = "serviceAccount:${google_service_account.iac_service_account.email}"
}

# Grant Foundation folder permissions to the IAC Service Account
resource "google_folder_iam_member" "grant_foundation_folder_permissions" {
  for_each = toset([
    "roles/owner",
    "roles/resourcemanager.folderAdmin"
  ])

  folder = google_folder.foundation_folder.id
  role   = each.key
  member = "serviceAccount:${google_service_account.iac_service_account.email}"
}

# Grant Bootstrap folder permissions to the IAC Service Account
resource "google_folder_iam_member" "grant_bootstrap_folder_permissions" {
  for_each = toset([
    "roles/owner",
    "roles/resourcemanager.folderAdmin"
  ])

  folder = google_folder.bootstrap_folder.id
  role   = each.key
  member = "serviceAccount:${google_service_account.iac_service_account.email}"
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