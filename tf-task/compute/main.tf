provider "google" {
  region = var.region
  zone = var.zone
}

resource "google_compute_instance" "default" {
  name         = "my-v3v3v3v3"
  machine_type = "e2-micro"

  allow_stopping_for_update = true

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-11"
    }
  }
  network_interface {
    network = var.vpc_name
    subnetwork = var.subnet_name
    access_config {}
  }
  metadata = {
    "google-compute-default-allow" = "http-server"
  }

  metadata_startup_script = file("${path.module}/script.sh")
}

