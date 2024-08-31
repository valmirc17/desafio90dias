variable "vm_name" {
    description = "Nome"
    type = string
    default = ""
}

variable "network_interface_id" {
  description = "ID da interface de rede"
  type        = string
  default = ""

}

variable "resource_group_name" {
    description = "Nome do grupo de recursos"
    type = string
    default = ""
  
}

variable "location" {
    description = "Local do  grupo de recursos"
    type = string
    default = ""
  
}

variable "vm_size" {
    description = "Tamanho dos recursos"
    type = string
    default = ""
  
}

variable "vm_disk_size" {
    description = "Tamanho do disco"
    type = string
    default = ""
  
}

variable "vm_publisher" {
    description = "Publicador da imagem"
    type = string
    default = ""
}

variable "vm_offer" {
    description = "Tipo da imagem"
    type = string
    default = ""
  
}

variable "vm_sku" {
    description = "SKU da imagem"
    type = string
    default = ""
  
}

variable "vm_version" {
    description = "Versão a ser utilizada da imagem"
    type = string
    default = ""
  
}

variable "vm_admin_user" {
    description = "Usuário administrador"
    type = string
    default = ""
}

variable "vm_admin_password" {
    description = "Senha do usuário administrador"
    type = string
    default = ""
}
