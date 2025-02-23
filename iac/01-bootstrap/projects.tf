# Create a CICD project under the Bootstrap folder
module "cicd_project" {
  source     = "../modules/project"
  name       = "CICD"
  project_id = "cicd"
  folder_id  = google_folder.bootstrap_folder.id
  services = [
    "iam.googleapis.com",
    "serviceusage.googleapis.com",
    "cloudbuild.googleapis.com",
    "cloudresourcemanager.googleapis.com",
  ]
  billing_account_id = var.billing_account_id
}
