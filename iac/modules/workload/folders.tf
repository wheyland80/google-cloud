resource "google_folder" "foundation_folder" {
  display_name = "${var.workload_name}"
  parent       = "folders/${var.foundation_folder_id}"
}
