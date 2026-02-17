resource "yandex_compute_instance" "db" {
  for_each = local.vm_map

  name        = each.value.vm_name
  platform_id = var.vm_web_platform-id
  allow_stopping_for_update = var.allow_stopping_for_update
  resources {
    cores         = each.value.cpu
    memory        = each.value.ram
    core_fraction = each.value.fraction
  }
  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu.image_id
      size = each.value.disk_volume
      type = each.value.disk_type
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

  metadata = {
    ssh-keys = "ubuntu:${file("~/.ssh/id_ed25519.pub")}"
  }
}
