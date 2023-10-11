provider "google" {
  region = var.region
}

resource "google_compute_network" "vpc_network" {
  name = "vpc-my"
}

resource "google_compute_subnetwork" "subnet" {
  name          = "subnet-my"
  ip_cidr_range = "10.0.0.0/16"
  region        = var.region
  network       = google_compute_network.vpc_network
}

resource "google_compute_firewall" "default" {
  name    = "firewall-my"
  network = google_compute_network.vpc_network

  allow {
    protocol = "icmp"
  }

  allow {
    protocol = "tcp"
    ports    = ["80", "8080", "443"]
  }

  allow {
    protocol = "ssh"
    ports    = ["22"]
  }

  source_tags = ["web"]
}
