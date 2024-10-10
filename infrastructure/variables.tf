# Define variables
variable "yc_token" {
  type = string
}

variable "yc_cloud_id" {
  type = string
}

variable "yc_folder_id" {
  type = string
}

variable "yc_zone" {
  type    = string
  default = "ru-central1-a"
}

variable "yc_instance_name" {
  type = string  
}

variable "yc_network_name" {
  type = string
}

variable "yc_subnet_name" {
  type = string
}

variable "yc_service_account_name" {
  type    = string
}

variable "ubuntu_image_id" {
  type    = string
}

variable "public_key_path" {
  type = string
}

variable "private_key_path" {
  type = string
}
