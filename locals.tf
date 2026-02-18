locals {
  /*metadata = {
    serial-port-enable = var.metadata["serial-port-enable"]
    ssh-keys           = "${var.metadata["ssh-keys"]}${var.vms_ssh_root_key}"
  }*/
  vm_map = { for vm in var.each_vm : vm.vm_name => vm }

  webservers = try([
    for vm in yandex_compute_instance.web : {
      name = vm.name
      hostname = try(vm.hostname, "") 
      fqdn = vm.fqdn
      ip   = vm.network_interface[0].nat_ip_address
    }
  ], [])
  
  databases = try([
    for vm in yandex_compute_instance.db : {
      name = vm.name
      hostname = try(vm.hostname, "")
      fqdn = vm.fqdn
      ip   = vm.network_interface[0].nat_ip_address
    }
  ], [])
  
  storage = try([
     {
      name = yandex_compute_instance.storage.name
      hostname = yandex_compute_instance.storage.hostname
      fqdn = yandex_compute_instance.storage.fqdn
      ip   = yandex_compute_instance.storage.network_interface[0].nat_ip_address
    }
  ], [])

  
  all_vms = concat(local.webservers, local.databases, local.storage)
}