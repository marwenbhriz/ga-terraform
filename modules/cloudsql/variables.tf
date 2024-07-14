variable "region" {
  type = string
}

variable "database_name" {
 type = string
 default = "ga-terraform"
}

variable "network" {
  type = string
}

variable "network_self_link" {
  type = string
}

variable "network_id" {
  type = string
}