# Create VPC Network
resource "google_compute_network" "vpc" {
  name                    = "${var.resource_prefix}-${var.environment_code}-${var.resource_code}-${var.resource_suffix}"
  auto_create_subnetworks = false
  project                 = var.project_id
}

resource "google_compute_subnetwork" "subnets" {
  for_each      = { for subnet in var.subnets : subnet.name => subnet }
  name          = "${var.resource_prefix}-${var.environment_code}-${each.value.name}-${var.resource_suffix}"
  ip_cidr_range = each.value.ip_cidr_range
  region        = each.value.region
  network       = google_compute_network.vpc.id
  project       = var.project_id
}

# # Shared VPC Host Project
# resource "google_compute_shared_vpc_host_project" "host" {
#   project = var.shared_vpc_project_id
# }

# # Service Project Associations
# resource "google_compute_shared_vpc_service_project" "service_projects" {
#   for_each       = var.service_project_ids
#   host_project   = google_compute_shared_vpc_host_project.host.project
#   service_project = each.value
# }

# Cloud Router for NAT
resource "google_compute_router" "nat_router" {
  name    = "${var.resource_prefix}-${var.environment_code}-cloud-router"
  project = var.project_id
  network = google_compute_network.vpc.id
  region  = var.region
}

# Cloud NAT Configuration
resource "google_compute_router_nat" "cloud_nat" {
  name                                = "${var.resource_prefix}-${var.environment_code}-cloud-nat"
  project                             = var.project_id
  router                              = google_compute_router.nat_router.name
  region                              = var.region
  nat_ip_allocate_option              = "AUTO_ONLY"
  source_subnetwork_ip_ranges_to_nat  = "ALL_SUBNETWORKS_ALL_IP_RANGES"
}