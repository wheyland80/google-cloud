# # Use for_each to dynamically fetch project details for each project ID
# data "google_project" "service_projects" {
#   for_each   = var.service_project_ids
#   project_id = each.value

#   depends_on = [ google_compute_shared_vpc_service_project.service_projects ]
# }

# # Grant network user permissions to the service projects
# resource "google_project_iam_member" "service_project_vpc_user" {
#   for_each = data.google_project.service_projects
#   project  = var.shared_vpc_project_id
#   role     = "roles/compute.networkUser"
#   member   = "serviceAccount:service-${each.value.number}@compute-system.iam.gserviceaccount.com"
# }