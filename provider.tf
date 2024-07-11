terraform {
  required_version = ">=0.1"
  backend "gcs" {
    bucket = "terraform-githubactions"
    prefix = "terraform-resources/"
  }
  required_providers {
    tls = {
      source = "hashicorp/tls"
    }
    google-beta = {
      source = "hashicorp/google-beta"
      version = "~>4"
    }
  }
}

provider "google" {
  #credentials = file("../credentials.json")
  region = var.accounts.region
  project = var.accounts.project
}
