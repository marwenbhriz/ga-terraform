resource "random_id" "mysql_grasysuser_password" {
  byte_length = 12
}

resource "google_sql_database_instance" "default" {
  name = var.database_name
  database_version = "MYSQL_8_0"
  region = var.region
  
  settings {
    tier = "db-f1-micro"
    disk_autoresize = true
    disk_autoresize_limit = 0
    disk_type = "PD_SSD"
    ip_configuration {
      ipv4_enabled    = false
      private_network = var.network
      enable_private_path_for_google_cloud_services = false
      require_ssl = false 

    }
    backup_configuration {
      backup_retention_settings {
        retained_backups = 7
        retention_unit   = "COUNT"
      }

      binary_log_enabled             = true
      enabled                        = true
      start_time                     = "00:00" 
      location                       = "asia"
      transaction_log_retention_days = 5
    } 
  }
 
  # change to true when we need tp prevent from deletion accident
  deletion_protection = false
}

resource "google_sql_database" "database" {
  name      = "books"
  instance  = google_sql_database_instance.default.name
  charset   = "utf8"
  collation = "utf8_general_ci"
}

resource "google_sql_user" "grasysuser" {
  name     = "gauser"
  instance = google_sql_database_instance.default.name
  host     = "%"
  password = "${random_id.mysql_grasysuser_password.b64_std}"
}

