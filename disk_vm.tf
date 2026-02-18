resource "yandex_compute_disk" "my_disk" {
    count = 3
  name     = "disk-${count.index}"
  type     = var.vms_disks["my_disk"]["type"]
  zone     = var.vms_disks["my_disk"]["zone_id"]
  size     = var.vms_disks["my_disk"]["size"]
  labels = {
    environment = "external_disk"
  }
}

resource "yandex_compute_instance" "storage" {
  depends_on = [ yandex_compute_disk.my_disk ]
  hostname = "storage"
  name        = "storage"
  platform_id = var.vm_web_platform-id
  allow_stopping_for_update = var.allow_stopping_for_update
  resources {
    cores         = var.vms_resources["web"]["cores"]
    memory        = var.vms_resources["web"]["memory"]
    core_fraction = var.vms_resources["web"]["core_fraction"]
  }
  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu.image_id
      size = var.vms_resources["web"]["hdd_size"]
      type = var.vms_resources["web"]["hdd_type"]
    }
  }
  scheduling_policy {
    preemptible = var.vm_web_should_be_preemptible
  }
  network_interface {
    subnet_id = yandex_vpc_subnet.develop.id
    nat       = var.vm_web_subnet_nat
    security_group_ids = [yandex_vpc_security_group.example.id]
  }
  dynamic "secondary_disk" {
    for_each = yandex_compute_disk.my_disk
    content {
      auto_delete = true
      disk_id     = secondary_disk.value.id
    }
  }
  metadata = {
    ssh-keys = "ubuntu:${file("~/.ssh/id_ed25519.pub")}"
  }
}