resource "google_cloudbuild_trigger" "github_trigger" {
  name = "public-github-repo-trigger"

  trigger_template {
    project_id  = module.cicd_project.id
    repo_name   = var.github_repo
    branch_name = var.github_branch
  }

  build {
    # Clone the public github google-cloud repository
    steps {
      name = "gcr.io/cloud-builders/git"
      args = ["clone", "https://github.com/${var.github_owner}/${var.github_repo}.git"]
    }

    # Step 2: Install OpenTofu CLI
    steps {
      name       = "ubuntu"
      entrypoint = "bash"
      args = [
        "-c",
        <<-EOT
          apt-get update && \
          apt-get install -y wget unzip && \
          wget https://github.com/opentofu/opentofu/releases/latest/download/tofu_Linux_x86_64.zip && \
          unzip tofu_Linux_x86_64.zip -d /usr/local/bin/ && \
          tofu version
        EOT
      ]
    }

    # Step 3: Initialize OpenTofu
    steps {
      name       = "ubuntu"
      entrypoint = "bash"
      args = [
        "-c",
        "cd ${var.github_repo} && tofu init"
      ]
    }
  }
}
