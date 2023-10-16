output "lb-ip" {
  value = google_compute_global_forwarding_rule.my_lb.ip_address 
}