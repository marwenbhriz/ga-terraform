output "database_ip" {
  value = module.cloudsql.public_ip_address
}

output "database_password" {
  value = nonsensitive(module.cloudsql.password)
}

output "database_name" {
  value = module.cloudsql.database_name
}
