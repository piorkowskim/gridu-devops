provider "google" {
  region = var.region
}

resource "google_compute_instance" "default {
  name = "my-instance"
  machine_type = "e2.micro"
  zone = var.zone

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-11"
  
  network_interface {
    network = google_cloud_network.vpc_network
  
  metadata_startup_script = <<SCRIPT
    sudo apt update && sudo apt upgrade -y
    sudo apt install -y apache2
    sudo apt install -y curl 
    sudo ufw allow 'WWW'
    curl -4 icanhazip.com
    SCRIPT
}
