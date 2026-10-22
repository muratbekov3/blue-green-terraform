variable "project_id" {
  description = "Google Cloud project ID."
  type        = string
}

variable "region" {
  description = "Google Cloud region."
  type        = string
}

variable "zone" {
  description = "Google Cloud zone for both MIGs."
  type        = string
}

variable "name_prefix" {
  description = "Prefix for infrastructure resource names."
  type        = string
}

variable "machine_type" {
  description = "Machine type for Blue and Green instances."
  type        = string
}

variable "image" {
  description = "Boot disk image for VM instances."
  type        = string
}

variable "vpc_name" {
  description = "Name of the existing VPC."
  type        = string
}

variable "subnet_name" {
  description = "Name of the existing public subnet."
  type        = string
}

variable "owner" {
  description = "Owner label using lowercase letters and underscores."
  type        = string
}

variable "blue_weight" {
  description = "Traffic weight for Blue. A positive value selects Blue."
  type        = number
  default     = 100

}

variable "green_weight" {
  description = "Traffic weight for Green."
  type        = number
  default     = 0

}