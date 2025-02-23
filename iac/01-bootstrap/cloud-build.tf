resource "google_cloudbuild_trigger" "bootstrap-plan-trigger" {
  name = "Bootstrap-Plan"
  provider = google-beta
  project = module.cicd_project.project_id
  location = var.region
  description = "OpenTofu Bootstrap Plan"

  service_account = google_service_account.iac_service_account.id

  repository_event_config {}

  approval_config {
    approval_required = false
  }

  build {
    timeout = "60s"
    step {
      name   = "ubuntu"
      script = "echo hello" # using script field
    }

    step {
      name = "gcr.io/cloud-builders/git"  # Use an image with git
      entrypoint = "bash"
      args = [
        "-c",
        <<-EOT
          git clone https://github.com/${var.github_owner}/${var.github_repo}.git
        EOT
      ]
    }

    step {
      name = "gcr.io/google.com/cloudsdktool/cloud-sdk:alpine"  # Use Google Cloud SDK image
      entrypoint = "bash"
      args = [
        "-c",
        <<-EOT
          # Download the installer script:
          curl --proto '=https' --tlsv1.2 -fsSL https://get.opentofu.org/install-opentofu.sh -o install-opentofu.sh

          # Give it execution permissions:
          chmod +x install-opentofu.sh

          # Run the installer:
          ./install-opentofu.sh --install-method apk

          cd /workspace/google-cloud/iac/01-bootstrap

          echo '
          terraform {
            backend "gcs" {
              bucket = "${google_storage_bucket.terraform_state.id}"
              prefix = "bootstrap/"
            }
          } ' > backend.tf

          cat backend.tf

          tofu init

          tofu plan -var "organisation_id=${var.organisation_id}" -var "billing_account_id=${var.billing_account_id}" -out /tmp/plan.out

          ls -Rl ./

          gcloud projects list
        EOT
      ]
    }

    tags = ["build", "newFeature"]

    queue_ttl = "20s"
    logs_bucket = "gs://${google_storage_bucket.cloud_build_logs.id}/"

    options {
      substitution_option = "ALLOW_LOOSE"
      dynamic_substitutions = true
      log_streaming_option = "STREAM_OFF"
      logging = "LEGACY"
    }
  }
}