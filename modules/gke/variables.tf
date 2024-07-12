variable "project_name" {
  type = string
}

variable "project_region" {
  type = string
}

variable "container_engine_version" {
  type = string
  default = "1.27.8-gke.1067000"
}

variable "cluster_name" {
  type = string
  default = "ga-gke"
}

variable "tags" {
  type = list(string)
  default = ["ga"]
}

variable "machine_type" {
  type = string
  default = "e2-small"
}

variable "networking_mode" {
  type = string
  default = "VPC_NATIVE"
}

variable "oauth_scopes" {
  type = list(string)
  default = [
        "https://www.googleapis.com/auth/logging.write",
        "https://www.googleapis.com/auth/monitoring",
        "https://www.googleapis.com/auth/devstorage.read_only",
        "https://www.googleapis.com/auth/service.management.readonly",
        "https://www.googleapis.com/auth/servicecontrol",
        "https://www.googleapis.com/auth/trace.append",
        "https://www.googleapis.com/auth/cloud-platform"
      ]
}

variable "locations" {
  type = list(string)
  default = [ "asia-northeast1-a", "asia-northeast1-b", "asia-northeast1-c" ]
}

variable "network" {
  type = string
}

variable "subnetwork" {
  type = string
}

variable "topic_id" {
  type = string
}

variable "ip_cidr_range" {
  type = string
  default = "10.0.2.0/28"
}

variable "authorized_ipv4_cidr_block" {
  type = string
}
