# Bucket for Cloud Build Logs
resource "google_storage_bucket" "cloud_build_logs" {
  name          = "cloud-build-logs-${random_id.random_suffix.hex}"
  project = module.cicd_project.project_id
  location      = var.region
  force_destroy = true

  lifecycle_rule {
    action {
      type = "Delete"
    }
    condition {
      age = 30 # Auto-delete logs older than 30 days
    }
  }

  uniform_bucket_level_access = true
  storage_class               = "STANDARD"

  labels = {
    purpose = "cloud-build-logs"
  }
}

# Bucket for Terraform State
resource "google_storage_bucket" "terraform_state" {
  name          = "terraform-state-${random_id.random_suffix.hex}"
  project = module.cicd_project.project_id
  location      = var.region
  force_destroy = false

  versioning {
    enabled = true
  }

  uniform_bucket_level_access = true
  storage_class               = "STANDARD"

  labels = {
    purpose = "terraform-state"
  }
}