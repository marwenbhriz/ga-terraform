output "network_name" {
  value = google_compute_network.benhriz-vpc.name
}

output "network" {
  value = google_compute_network.benhriz-vpc.self_link
}

output "subnetwork" {
  value = google_compute_subnetwork.benhriz-subnetwork.self_link
}

output "self_link" {
  value = google_compute_network.benhriz-vpc.self_link
}

output "id" {
  value = google_compute_network.benhriz-vpc.id
}
