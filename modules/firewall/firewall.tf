# create compute firewall for gce instance to allow ports access to our gcs/applications access. 
resource "google_compute_firewall" "ga-firewall" {
  name    = var.firewall_name
  network = var.network_name
  project = var.project_name

  log_config {
    metadata =  "INCLUDE_ALL_METADATA"
  }

  allow {
    protocol = "TCP"

    ports = var.tcp_ports
  }

  allow {
    protocol = "ICMP"
  }

  source_ranges = var.source_ranges

  target_tags = [
    var.target_tags
  ]
}