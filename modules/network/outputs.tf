output "network_name" {
  value = google_compute_network.ga-vpc.name
}

output "network" {
  value = google_compute_network.ga-vpc.self_link
}

output "subnetwork" {
  value = google_compute_subnetwork.ga-subnetwork.self_link
}

output "self_link" {
  value = google_compute_network.ga-vpc.self_link
}

output "id" {
  value = google_compute_network.ga-vpc.id
}
