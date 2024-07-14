resource "google_spanner_instance" "default" {
  config       = var.config
  display_name = "Ga Spanner Instance"
  autoscaling_config {
    autoscaling_limits {
      min_nodes = 1 // OR Min_processing_units            = 1000
      max_nodes = 2 // OR max_processing_units            = 2000
    }
    autoscaling_targets {
      high_priority_cpu_utilization_percent = 75
      storage_utilization_percent           = 90
    }
  }
  labels = {
    "foo" = "ga"
  }
}

resource "google_spanner_database" "database" {
  instance = google_spanner_instance.default.name
  name     = "ga-database"
  version_retention_period = "3d"
  ddl = [
    "CREATE TABLE books (Id INT64 NOT NULL,) PRIMARY KEY(Id)",
  ]
  deletion_protection = false
}