variable "sa_name" {
    description = "Nome da conta"
    type = string
    default = ""
}

variable "sc_name" {
    description = "Nome do container"
    type = string
    default = ""
  
}

variable "resource_group_name" {
    description = "Nome do grupo de recursos"
    type = string
    default = ""
  
}

variable "location" {
    description = "Local do recurso"
    type = string
    default = ""
}
