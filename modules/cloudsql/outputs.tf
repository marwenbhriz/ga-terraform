output "password" {
  value = google_sql_user.grasysuser.password
}

output "database_name" {
  value = google_sql_database_instance.default.name
}

output "public_ip_address" {
  value = google_sql_database_instance.default.public_ip_address
}