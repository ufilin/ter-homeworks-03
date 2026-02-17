locals {

  #web_instance_name = "web-${count.index+1}"
  #db_instance_name  = "db-${var.project_name}-${var.environment}"

  metadata = {
    serial-port-enable = var.metadata["serial-port-enable"]
    ssh-keys           = "${var.metadata["ssh-keys"]}${var.vms_ssh_root_key}"
  }
}
