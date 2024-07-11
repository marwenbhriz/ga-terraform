variable "tcp_ports" {
  type = list(string)
  default = [
      "443",  // https
      "22",   // ssh
      "80",   // http
      "3306", // mysql
    ]
}

variable "source_ranges" {
  type = list(string)
  default = [
    # my home ip
    "113.154.19.225"
  ]
}

variable "target_tags" {
  type = string
  default = "ga-firewall"
}

variable "firewall_name" {
  type = string
  default = "ga-firewall"
}

variable "network_name" {
  type = string
}

variable "project_name" {
  type = string
}