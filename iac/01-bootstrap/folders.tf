resource "google_folder" "bootstrap_folder" {
  display_name = "Bootstrap"
  parent       = "organizations/${var.organisation_id}"
}

resource "google_folder" "foundation_folder" {
  display_name = "Foundation"
  parent       = "organizations/${var.organisation_id}"
}
