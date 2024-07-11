data google_container_engine_versions version {
  project        = var.project_name
  provider       = google-beta
  location       = var.project_region
  version_prefix = var.container_engine_version
}

// Get the default service account
data "google_compute_default_service_account" "default" {
}

resource "google_container_cluster" "benhriz-cluster" {
  provider                  = google-beta
  name                      = var.cluster_name
  location                  = var.project_region
  project                   = var.project_name
  node_locations            = [ for location in var.locations : "${location}" ]

  initial_node_count        = 1
  default_max_pods_per_node = 100
  network                   = var.network
  subnetwork                = var.subnetwork
  networking_mode           = var.networking_mode
  remove_default_node_pool  = false
  #deletion_protection = true

  node_config {
    machine_type = var.machine_type
    tags         = var.tags
    oauth_scopes = var.oauth_scopes
    spot         = true
  }

  ip_allocation_policy {
  }

  vertical_pod_autoscaling {
    enabled = true
  }

  cluster_autoscaling {
    enabled = true
    resource_limits {
      resource_type = "cpu"
      minimum       = 1
      maximum       = 2
    }
    resource_limits {
      resource_type = "memory"
      maximum       = 6
    }
  }

  addons_config {
    http_load_balancing {
      disabled = false
    }
  }

  mesh_certificates {
    enable_certificates = false
  }

  notification_config {
    pubsub {
        enabled = true
        topic   = var.topic_id
    }
  }
}

resource "google_container_node_pool" "default" {
  name              = "nodepool-${format("%02d", count.index + 1)}"
  location          = var.project_region
  cluster           = google_container_cluster.benhriz-cluster.id
  node_count        = 1
  max_pods_per_node = 20
  count             = 1

  autoscaling {
    min_node_count = 1
    max_node_count = 1
  }

  management {
    auto_repair  = true
    auto_upgrade = true
  }
}

data "google_client_config" "current" {}
