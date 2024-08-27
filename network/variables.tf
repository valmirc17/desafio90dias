variable "location" {
    description = "Localização onde os recursos serão criados"
    type = string
    default = ""  
}

variable "resource_group_name" {
    description = "Nome do grupo de recursos"
    type = string
    default = ""
}

variable "virtual_network_name" {
    description = "Nome da rede virtual"
    type = string
    default = ""
}

variable "address_space" {
    description = "Espaço de endereços da rede virtual"
    type = list(string)
    default = []
  
}

variable "environment" {
    description = "Tag de identificação do ambiente"
    type = string
    default = ""
}