output "load_balancer_ip" {
  description = "Global public IP address of the load balancer."
  value       = google_compute_global_address.lb.address
}

output "load_balancer_url" {
  description = "HTTP URL of the Blue-Green application."
  value       = "http://${google_compute_global_address.lb.address}"
}

output "active_environment" {
  description = "Environment currently selected by the URL map."
  value       = var.blue_weight > 0 ? "Blue" : "Green"
}

output "blue_mig" {
  description = "Name of the Blue regional MIG."
  value       = google_compute_region_instance_group_manager.env["blue"].name
}

output "green_mig" {
  description = "Name of the Green regional MIG."
  value       = google_compute_region_instance_group_manager.env["green"].name
}