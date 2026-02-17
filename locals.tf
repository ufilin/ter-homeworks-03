locals {
  /*metadata = {
    serial-port-enable = var.metadata["serial-port-enable"]
    ssh-keys           = "${var.metadata["ssh-keys"]}${var.vms_ssh_root_key}"
  }*/
  vm_map = { for vm in var.each_vm : vm.vm_name => vm }
}