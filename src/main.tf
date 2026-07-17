resource "yandex_vpc_network" "web" {
  name = var.vpc_name
}
resource "yandex_vpc_subnet" "web" {
  name           = var.vpc_name
  zone           = var.vm_web_zone
  network_id     = yandex_vpc_network.web.id
  v4_cidr_blocks = var.default_cidr
}

resource "yandex_vpc_network" "db" {
  name = var.vm_db_vpc_name
}

resource "yandex_vpc_subnet" "db-subnet" {
  name           = var.vm_db_vpc_name
  zone           = var.vm_db_zone
  network_id     = yandex_vpc_network.db.id
  v4_cidr_blocks = var.vm_db_cidr
}

data "yandex_compute_image" "ubuntu-web" {
  family = var.vm_web_image
}

resource "yandex_compute_instance" "web" {
  name        = local.web_instance_name
  zone		  = var.vm_web_zone
  platform_id = var.vm_web_platform_id
  resources {
    cores         = var.vms_resources["web"].cores
    memory        = var.vms_resources["web"].memory
    core_fraction = var.vms_resources["web"].core_fraction
  }
  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu-web.image_id
    }
  }
  scheduling_policy {
    preemptible = true
  }
  network_interface {
    subnet_id = yandex_vpc_subnet.web.id
    nat       = false
  }

  metadata = {
    "serial-port-enable" = var.vms_metadata_serial_port_enable
    "ssh-keys"          = var.vms_ssh_public_key
  }
}

data "yandex_compute_image" "ubuntu-db" {
  family = var.vm_db_image
}

resource "yandex_compute_instance" "db" {
  name        = local.db_instance_name
  zone		  = var.vm_db_zone
  platform_id = var.vm_db_platform_id
  resources {
    cores         = var.vms_resources["db"].cores
    memory        = var.vms_resources["db"].memory
    core_fraction = var.vms_resources["db"].core_fraction
  }
  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu-db.image_id
    }
  }
  scheduling_policy {
    preemptible = true
  }
  network_interface {
    subnet_id = yandex_vpc_subnet.db-subnet.id
    nat       = false
  }

  metadata = {
    "serial-port-enable" = var.vms_metadata_serial_port_enable
    "ssh-keys"          = var.vms_ssh_public_key
  }
}