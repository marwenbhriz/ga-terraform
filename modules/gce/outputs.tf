output "instances" {
  value = google_compute_instance.default.*.self_link
}
