###cloud vars
variable "token" {
  type        = string
  description = "OAuth-token; https://cloud.yandex.ru/docs/iam/concepts/authorization/oauth-token"
}

variable "cloud_id" {
  type        = string
  description = "https://cloud.yandex.ru/docs/resource-manager/operations/cloud/get-id"
}

variable "folder_id" {
  type        = string
  description = "https://cloud.yandex.ru/docs/resource-manager/operations/folder/get-id"
}

variable "default_zone" {
  type        = string
  default     = "ru-central1-a"
  description = "https://cloud.yandex.ru/docs/overview/concepts/geo-scope"
}
variable "default_cidr" {
  type        = list(string)
  default     = ["10.0.1.0/24"]
  description = "https://cloud.yandex.ru/docs/vpc/operations/subnet-create"
}

variable "vpc_name" {
  type        = string
  default     = "develop"
  description = "VPC network&subnet name"
}

variable "vm_web_family" {
  type        = string
  default     = "ubuntu-2204-lts"
  description = "https://cloud.yandex.ru/docs/compute/operations/images-with-versions"
}

variable "vm_web_platform-id" {
    type        = string
    default     = "standard-v1"
    description = "https://cloud.yandex.ru/docs/compute/operations/images-with-versions"
}

variable "vm_web_should_be_preemptible" {
    type        = bool
    default     = true
    description = "Should the VM be preemptible"
}

variable "vm_web_subnet_nat" {
    type        = bool
    default     = true
    description = "Should the VM have NAT"
}

/*variable "vms_ssh_root_key" {
  type        = string
  description = "ssh-keygen -t ed25519"
  sensitive = true
}
*/
variable "project_name" {
  type        = string
  default     = "develop"
  description = "Project name"
}

variable "environment" {
  type        = string
  default     = "arthur"
  description = "Environment"
}

variable "allow_stopping_for_update" {
  type = bool
  default = true
}

variable "vms_resources" {
  type = map(object(
      {
    cores         = number
    memory        = number
    core_fraction = number
    hdd_size      = number
    hdd_type      = string
  }))

  default = {
    web = {
      cores = 2
      memory = 1
      core_fraction = 5
      hdd_size = 10
      hdd_type = "network-hdd"
    }
  }
}

variable "metadata" {
  type = object({
    serial-port-enable = number
    ssh-keys           = string
  })

  default = {
    serial-port-enable = 1
    ssh-keys           = "ubuntu:"
  }
}
variable "each_vm" {
  type = list(object({ 
    vm_name     = string, 
    cpu         = number, 
    ram         = number, 
    disk_volume = number,
    disk_type   = string,
    fraction     = number,

  }))
  default = [
    {
      vm_name     = "main"
      cpu         = 2
      ram         = 2
      disk_volume = 20
      disk_type   = "network-hdd"
      fraction    = 5
    },
    {
      vm_name     = "replica"
      cpu         = 4
      ram         = 4
      disk_volume = 10
      disk_type   = "network-hdd"
      fraction    = 20
    }
  ]
}