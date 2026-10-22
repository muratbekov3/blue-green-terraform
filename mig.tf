resource "google_compute_region_instance_group_manager" "env" {
  for_each = local.environments

  name               = "${var.name_prefix}-${each.key}-mig"
  region             = var.region
  base_instance_name = "${var.name_prefix}-${each.key}"

  distribution_policy_zones = [
    "${var.region}-a",
    "${var.region}-b"
  ]

  version {
    instance_template = google_compute_instance_template.env[each.key].id
  }

  target_size = 2

  named_port {
    name = "http"
    port = 80
  }

  update_policy {
    type                  = "PROACTIVE"
    minimal_action        = "REPLACE"
    max_surge_fixed       = 1
    max_unavailable_fixed = 0
  }
}