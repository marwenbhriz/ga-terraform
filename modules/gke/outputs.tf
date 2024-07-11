output "name" {
  value = google_container_cluster.benhriz-cluster.name
}

output "token" {
  value = data.google_client_config.current.access_token
}

output "host" {
  value = google_container_cluster.benhriz-cluster.endpoint
}

output "cluster_ca_certificate" {
  value = google_container_cluster.benhriz-cluster.master_auth[0].cluster_ca_certificate
}

