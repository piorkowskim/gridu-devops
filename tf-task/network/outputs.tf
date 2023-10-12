output "vpc_name" {
  description = "Name of the VPC network"
  value       = google_compute_network.my_network.name
}
output "subnet_name" {
    description = "Name of the subnet"
    value = google_compute_subnetwork.my_subnet.name
}