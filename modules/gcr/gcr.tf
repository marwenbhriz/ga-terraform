
resource "google_artifact_registry_repository" "ga-repo" {
  location      = var.project_region
  repository_id = var.repository_id
  description   = "ga docker repository"
  format        = "DOCKER"
  mode          = "REMOTE_REPOSITORY"
  project = var.project_name

  remote_repository_config {
    description = "docker hub"
    docker_repository {
      public_repository = "DOCKER_HUB"
    }
  }
}

/*
resource "google_artifact_registry_repository" "virtual" {
  location      = var.accounts.region
  repository_id = "${var.name.prefix}-ar-repo-virtual-${var.name.suffix}"
  format        = "DOCKER"
  mode          = "VIRTUAL_REPOSITORY"

  virtual_repository_config {
    upstream_policies {
      id          = google_artifact_registry_repository.remote.id
      repository  = google_artifact_registry_repository.remote.id
      priority    = 1
    }
  }
}


resource "google_container_registry" "registry" {
  project  = var.project_name
  location = var.project_region
}


resource "google_storage_bucket_iam_member" "viewer" {
  bucket = google_container_registry.registry.id
  role = "roles/storage.objectViewer"
  member = "user:benhriz@example.com"
}
*/