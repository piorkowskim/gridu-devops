provider "google" {
  region = var.region
}

resource "google_compute_network" "my_network" {
  name = "my-vpc-network"
}

resource "google_compute_subnetwork" "my_subnet" {
  name          = "my-subnet"
  network       = google_compute_network.my_network.name
  ip_cidr_range = "10.0.0.0/24"
}

resource "google_compute_firewall" "allow-http-ssh" {
  name    = "allow-http-ssh"
  network = google_compute_network.my_network.name

  allow {
    protocol = "tcp"
    ports    = ["22", "80"]
  }

  source_ranges = ["0.0.0.0/0"]
}

