output "instance" {
  value = google_compute_instance.default.*.self_link
}

output "ip" {
  value       = google_compute_instance.default.network_interface.0.network_ip
  description = "The IP address of the jump ops instance."
}