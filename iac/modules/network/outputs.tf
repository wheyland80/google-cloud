output "vpc_network_id" {
  description = "The ID of the VPC network"
  value       = google_compute_network.vpc.id
}

output "subnet_ids" {
  description = "A map of subnet names to their IDs"
  value       = { for subnet, config in google_compute_subnetwork.subnets : subnet => config.id }
}

output "router_id" {
  description = "The ID of the Cloud Router for NAT"
  value       = google_compute_router.nat_router.id
}

output "cloud_nat_id" {
  description = "The ID of the Cloud NAT configuration"
  value       = google_compute_router_nat.cloud_nat.id
}