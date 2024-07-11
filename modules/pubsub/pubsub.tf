resource "google_pubsub_topic" "notifications" {
  name = var.notification_name
  message_retention_duration = "86600s"
}