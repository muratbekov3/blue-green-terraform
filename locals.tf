locals {
  labels = {
    terraform = "true"
    project   = var.project_id
    owner     = var.owner
  }

  environments = {
    blue  = "start-blue.sh"
    green = "start-green.sh"
  }
}