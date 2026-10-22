resource "google_compute_instance_template" "env" {
  for_each = local.environments

  name_prefix  = "${var.name_prefix}-${each.key}-template-"
  machine_type = var.machine_type
  region       = var.region

  tags = ["http-server"]

  labels = local.labels

  disk {
    source_image = var.image
    auto_delete  = true
    boot         = true
    disk_size_gb = 10
  }

  network_interface {
    subnetwork = data.google_compute_subnetwork.public.self_link

    access_config {}
  }

  metadata_startup_script = file(
    "${path.module}/${each.value}"
  )

}