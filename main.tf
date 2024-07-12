// import hello module
module "hello" {
  source       = "./modules/hello"
}

// import pubsub module
module "pubsub" {
  source       = "./modules/pubsub"
}

// import network module
module "network" {
  source       = "./modules/network"
  project_name = var.accounts.project
  project_region = var.accounts.region
}

// import gcr module
module "gcr" {
  source       = "./modules/gcr"
  project_name = var.accounts.project
  project_region = var.accounts.region
}

// import jump ops firewall module
module "firewall" {
  source       = "./modules/firewall"
  project_name = var.accounts.project
  network_name = module.network.network_name

  // need to wait until network modules creation
  depends_on = [ module.network ]
}


// import gce module
module "gce" {
  source       = "./modules/gce"
  project_name = var.accounts.project
  network = module.network.network
  firewall_name = module.firewall.firewall_name
  subnetwork = module.network.subnetwork
  project_zone = var.accounts.zone

  // need to wait until firewall and network modules creation
  depends_on = [ module.network ]
}

// import gke module
module "gke" {
  source       = "./modules/gke"
  project_name = var.accounts.project
  project_region = var.accounts.region
  network = module.network.network
  subnetwork = module.network.subnetwork
  topic_id = module.pubsub.topic_id
  #ip_cidr_range = module.network.ip_cidr_range
  authorized_ipv4_cidr_block = "${module.gce.ip[0]}/32"

  depends_on = [ module.pubsub, module.network, module.gce ]
}

// import spanner module
module "spanner" {
  source       = "./modules/spanner"

}

