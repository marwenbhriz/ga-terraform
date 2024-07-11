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

  metadata_startup_script = <<-EOF
    set -o errexit  # always exit on error
    set -o errtrace # trap errors in functions as well
    set -o pipefail # don't ignore exit codes when piping output
    set -o posix    # more strict failures in subshells

    IFS="$(printf "\n\t")"

    cd "$(mktemp -d /tmp/kubectl-XXX)"

    version="1.13.0"
    echo -n "Installing kubectl v${version}…"
    url="https://storage.googleapis.com/kubernetes-release/release/v${version}/bin/linux/amd64/kubectl"
    curl --silent --location --fail --remote-name "${url}"
    # Use sudo if needed, empty string if not
    sudo_command=$(command -v sudo)
    "${sudo_command}" install -m 755 kubectl /usr/local/bin
    echo ✓
  EOF

  #, "http-server","https-server", "lb-health-check"
  tags = [var.firewall_name]

  lifecycle {
   prevent_destroy = false
  }
}
