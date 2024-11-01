variable "adf_name" {
    description = "Nome do recurso"
    type = string
    default = ""
  
}

variable "location" {
    description = "Local do recurso"
    type = string
    default = ""

}

variable "resource_group_name" {
    description = "Nome do grupo de recursos"
    type = string
    default = ""
  
}

variable "account_name" {
    description = "Nome da organização do Azure Devops"
    type = string
    default = ""
  
}

variable "branch_name" {
    description = "Nome da branch"
    type = string
    default = ""
  
}

variable "project_name" {
    description = "Nome do projeto"
    type = string
    default = ""
  
}

variable "repository_name" {
    description = "Nome do repositório"
    type = string
    default = ""
  
}

variable "root_folder" {
    description = "Caminho da pasta"
    type = string
    default = ""
  
}

variable "tenant_id" {
    description = "ID do Diretório Padrão (Entra ID)"
    type = string
    default = ""
  
}

variable "storage_account_id" {
    description = "ID da conta de armazenamento"
    type = string
    default = ""
}

variable "storage_account_name" {
    description = "Nome da conta de armazenamento"
    type = string
    default = ""
  
}

variable "storage_container_name" {
    description = "Nome da conta de armazenamento"
    type = string
    default = ""
  
}

variable "primary_connection_string" {
    description = ""
    type = string
    default = ""
}

variable "subnet_def_id" {
    description = "ID da sub-rede default"
    type = string
    default = ""
  
}

variable "subnet_pe_id" {
    description = "ID da sub-rede do endpoint privado"
    type = string
    default = ""
  
}

variable "vnet_name" {
    description = "Nome da rede virtual"
    type = string
    default = ""
}

variable "virtual_network_id" {
    description = "ID da rede virtual"
    type = string
    default = ""
}
variable "environment" {
    description = "Tag de identificação do ambiente"
    type = string
    default = ""
  
}
