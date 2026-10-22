data "google_compute_network" "vpc" {
  name = var.vpc_name
}

data "google_compute_subnetwork" "public" {
  name   = var.subnet_name
  region = var.region
}