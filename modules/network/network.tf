resource "google_compute_network" "ga-vpc" {
  name                    = "${var.network_name}"
  project = "${var.project_name}"
  auto_create_subnetworks = false
  lifecycle {
    ignore_changes = all
  }
}

resource "google_compute_subnetwork" "ga-subnetwork" {
  name   = "${var.subnetwork_name}"
  region = var.project_region
  description = "ga-subnet-1a"
  ip_cidr_range = "${var.ip_cidr_range}"
  network       = google_compute_network.benhriz-vpc.self_link

  lifecycle {
    ignore_changes = all
  }

  log_config {
    metadata = "INCLUDE_ALL_METADATA"
  }
}