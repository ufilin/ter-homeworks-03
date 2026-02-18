resource "local_file" "ansible_inventory" {
  filename = "${path.module}/hosts.ini"
  
  content = templatefile("${path.module}/hosts.tftpl", {
    webservers = local.webservers
    databases  = local.databases
    storage    = local.storage
  })
  
  file_permission = "0644"
}