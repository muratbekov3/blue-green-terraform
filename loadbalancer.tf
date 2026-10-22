resource "google_compute_health_check" "http" {
  name = "${var.name_prefix}-hc"

  check_interval_sec  = 10
  timeout_sec         = 5
  healthy_threshold   = 2
  unhealthy_threshold = 3

  http_health_check {
    port         = 80
    request_path = "/"
  }
}

# Blue and Green Backend Services

resource "google_compute_backend_service" "env" {
  for_each = local.environments

  name                  = "${var.name_prefix}-${each.key}-bs"
  protocol              = "HTTP"
  port_name             = "http"
  load_balancing_scheme = "EXTERNAL"
  timeout_sec           = 30
  session_affinity      = "NONE"

  health_checks = [
    google_compute_health_check.http.id
  ]

  backend {
    group = google_compute_instance_group_manager.env[
      each.key
    ].instance_group

    balancing_mode  = "UTILIZATION"
    capacity_scaler = 1.0
  }
}

# URL Map: Select Active Environment

resource "google_compute_url_map" "blue_green" {
  name = "${var.name_prefix}-url-map"

  default_service = var.blue_weight > 0 ? (
    google_compute_backend_service.env["blue"].id
    ) : (
    google_compute_backend_service.env["green"].id
  )

}

# Target HTTP Proxy

resource "google_compute_target_http_proxy" "blue_green" {
  name    = "${var.name_prefix}-http-proxy"
  url_map = google_compute_url_map.blue_green.id
}

# Global Static IP

resource "google_compute_global_address" "lb" {
  name = "${var.name_prefix}-lb-ip"
}

# Global Forwarding Rule

resource "google_compute_global_forwarding_rule" "blue_green" {
  name                  = "${var.name_prefix}-forwarding-rule"
  target                = google_compute_target_http_proxy.blue_green.id
  port_range            = "80"
  ip_protocol           = "TCP"
  load_balancing_scheme = "EXTERNAL"
  ip_address            = google_compute_global_address.lb.address
}