resource "google_compute_instance" "default" {

  name         = "jump-ops-${format("%02d", count.index + 1)}"
  machine_type = "e2-standard-4"
  project      = var.project_name
  zone         = var.project_zone
  count        = 1

  boot_disk {
    initialize_params {
      image = "centos-cloud/centos-7"
    }
  }
  network_interface {
    network    = var.network
    subnetwork = var.subnetwork
    
    //access_config {
      // Include this section to give the VM an external ip address
    //}
  }
  #, "http-server","https-server", "lb-health-check"
  tags = [var.firewall_name, "http-server","https-server"]

  lifecycle {
   prevent_destroy = false
  }
}
