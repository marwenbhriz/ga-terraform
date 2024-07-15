resource "google_compute_instance" "default" {

  name         = "jump-ops-${format("%02d", count.index + 1)}"
  machine_type = "e2-small"
  project      = var.project_name
  zone         = var.project_zone
  count        = 1

  boot_disk {
    initialize_params {
      image = "centos-stream-9-v20240709"
    }
  }

  shielded_instance_config {
    enable_secure_boot          = true
    enable_vtpm                 = true
    enable_integrity_monitoring = true
  }

  scheduling {
    preemptible       = true
    automatic_restart = false
  }

  network_interface {
    network    = var.network
    subnetwork = var.subnetwork
    
    access_config {
      // Include this section to give the VM an external ip address
    }
  }

  metadata_startup_script = "${path.module}/compute_instance_startup.sh"

  #, "http-server","https-server", "lb-health-check"
  tags = [var.firewall_name]

  lifecycle {
   prevent_destroy = false
  }
}
