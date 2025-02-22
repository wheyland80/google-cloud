# Create a Service Account for CI/CD pipelines
resource "google_service_account" "cicd_service_account" {
  account_id   = "iac-service-account"
  display_name = "IAC CI/CD Pipeline Service Account"
  project      = module.cicd_project.project_id
}

# # Assign necessary roles to the CI/CD Service Account
resource "google_project_iam_member" "cicd_sa_roles" {
  for_each = toset([
    "roles/cloudbuild.builds.editor",
    "roles/source.reader",
    "roles/iam.serviceAccountUser"
  ])
  project = module.cicd_project.project_id
  role    = each.key
  member  = "serviceAccount:${google_service_account.cicd_service_account.email}"
}
