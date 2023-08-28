resource "yandex_vpc_network" "develop" {
  name = var.vpc_name
}
resource "yandex_vpc_subnet" "develop" {
  name           = var.vpc_name
  zone           = var.default_zone
  network_id     = yandex_vpc_network.develop.id
  v4_cidr_blocks = var.default_cidr
}


data "yandex_compute_image" "centos" {
  family = "${var.vm_os}"
}
resource "yandex_compute_instance" "platform" {
  count = 3
  name        = "vm-${count.index}"

resources {
    cores         = 2
    memory        = 1
    core_fraction = 5
  }
  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.centos.image_id
    }
  }
  scheduling_policy {
    preemptible = true
  }
  network_interface {
    subnet_id = yandex_vpc_subnet.develop.id
    nat       = true
  }

  metadata = {
    serial-port-enable = var.vm_metadata.serial-port-enable
    ssh-keys           = "centos:${local.ssh_key}"
  }
}

data "template_file" "config" {
#  template = file("./config.yml")
 vars = {
 ssh_key = local.ssh_key
 }
}