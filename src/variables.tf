variable "resource_group_name" {
  type    = string
  default = "RG-Terraform-Hackaton"
}

variable "location" {
  type    = string
  default = "westeurope"
}

variable "cluster" {
  type = object({
    name         = string,
    node_count   = number,
    vm_size      = string,
    vm_disk_size = number
  })
  default = {
    name         = "terraform-aks",
    node_count   = 2,
    vm_size      = "Standard_B2s",
    vm_disk_size = 30
  }
}

variable "service_principal" {
  type = object({
    client_id     = string,
    client_secret = string
  })
  default = {
    client_id     = "",
    client_secret = ""
  }
}

variable "ingress" {
  type = object({
    name      = string,
    className = string
  })
  default = {
    name      = "ingress",
    className = "my-ingress"
  }
}
