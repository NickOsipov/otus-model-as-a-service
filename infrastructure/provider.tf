# Объявление провайдера
terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
    }
  }
  required_version = ">= 1.00"
}

provider "yandex" {
  zone      = var.yc_zone
  folder_id = var.yc_folder_id
  token     = var.yc_token
  cloud_id  = var.yc_cloud_id
}
