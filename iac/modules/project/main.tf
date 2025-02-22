resource "random_id" "project_suffix" {
  byte_length = 8
}

resource "google_project" "project" {
  name                = var.name
  project_id          = "${var.project_id}-${random_id.project_suffix.hex}"
  folder_id           = var.folder_id
  auto_create_network = false
  billing_account = var.billing_account_id

  deletion_policy = "DELETE"

  lifecycle {
    prevent_destroy = false
  }
}

resource "google_project_service" "services" {
  for_each = toset(var.services)
  project  = google_project.project.project_id
  service  = each.key

  disable_on_destroy = false

  lifecycle {
    prevent_destroy = false
  }
}