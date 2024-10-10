# Create a service account
resource "yandex_iam_service_account" "sa" {
  name        = var.yc_service_account_name
  description = "Service account for VM management"
}

# Grant permissions to the service account
resource "yandex_resourcemanager_folder_iam_member" "sa-editor" {
  folder_id = var.yc_folder_id
  role      = "editor"
  member    = "serviceAccount:${yandex_iam_service_account.sa.id}"
}

# Create a new instance
resource "yandex_compute_instance" "vm-1" {
  name               = var.yc_instance_name
  service_account_id = yandex_iam_service_account.sa.id

  resources {
    cores  = 2
    memory = 8
  }

  boot_disk {
    initialize_params {
      image_id = var.ubuntu_image_id
    }
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.subnet-1.id
    nat       = true
  }

  metadata = {
    ssh-keys = "ubuntu:${file(var.public_key_path)}"
  }

  connection {
    type        = "ssh"
    user        = "ubuntu"
    private_key = file(var.private_key_path)
    host        = self.network_interface.0.nat_ip_address
  }

  provisioner "remote-exec" {
    inline = [
      "sudo apt-get update",
      "sudo apt-get install -y apt-transport-https ca-certificates curl software-properties-common",
      "curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -",
      "sudo add-apt-repository \"deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable\"",
      "sudo apt-get update",
      "sudo apt-get install -y docker-ce docker-ce-cli containerd.io",
      "sudo usermod -aG docker $USER",
    ]
  }
}

# Create a VPC network
resource "yandex_vpc_network" "yc_network" {
  name = var.yc_network_name
}

# Create a subnet
resource "yandex_vpc_subnet" "subnet-1" {
  name           = var.yc_subnet_name
  zone           = var.yc_zone
  network_id     = yandex_vpc_network.yc_network.id
  v4_cidr_blocks = ["192.168.10.0/24"]
}

# Output the external IP address of the instance
output "external_ip_address_vm_1" {
  value = yandex_compute_instance.vm-1.network_interface.0.nat_ip_address
}
