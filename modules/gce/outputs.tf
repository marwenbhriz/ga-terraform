output "instance" {
  value = google_compute_instance.default.*.self_link
}
