resource "random_id" "mysql_gauser_password" {
  byte_length = 12
}

resource "google_compute_global_address" "private_ip_address" {
  name          = "ga-private-ip-address"
  purpose       = "VPC_PEERING"
  address_type  = "INTERNAL"
  address       = "191.100.0.0"
  prefix_length = 20
  network       = var.network_self_link
}

//resource "google_service_networking_connection" "ga-private-vpc-connection" {
//  network                 = var.network
//  service                 = "servicenetworking.googleapis.com"
//  reserved_peering_ranges = [google_compute_global_address.private_ip_address.name]
//}

resource "google_sql_database_instance" "default" {
  name = var.database_name
  database_version = "MYSQL_8_0"
  region = var.region
  
  settings {
    tier = "db-f1-micro"
    disk_autoresize = true
    disk_autoresize_limit = 0
    disk_type = "PD_SSD"
    //ip_configuration {
      //ipv4_enabled    = false
      //private_network = var.network_id
      //enable_private_path_for_google_cloud_services = false
      //require_ssl = false 
      #ssl_mode = false
    //}
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
  name      = "tasks"
  instance  = google_sql_database_instance.default.name
  charset   = "utf8"
  collation = "utf8_general_ci"
}

resource "google_sql_user" "gauser" {
  name     = "gauser"
  instance = google_sql_database_instance.default.name
  host     = "%"
  password = "${random_id.mysql_gauser_password.b64_std}"
}

