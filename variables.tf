/*----------------Network-------------*/
variable "location" {
  description = "Localização onde os recursos serão criados"
  type        = string
  default     = ""
}

variable "resource_group_name" {
  description = "Nome do grupo de recursos"
  type        = string
  default     = ""
}

variable "virtual_network_name" {
  description = "Nome da rede virtual"
  type        = string
  default     = ""
}

variable "subnet_name" {
  description = "Nome da sub rede"
  type        = string
  default     = ""
}

variable "nic_name" {
  description = "Nome da interface de rede"
  type        = string
  default     = ""

}

variable "address_space" {
  description = "Espaço de endereços da rede virtual"
  type        = list(string)
  default     = []

}

variable "address_prefix" {
  description = "Pool de endereços da sub rede"
  type        = list(string)
  default     = []
}

variable "address_prefix_pe" {
  description = "Pool de endereços da sub rede do endpoint privado"
  type        = list(string)
  default     = []
}

variable "environment" {
  description = "Tag de identificação do ambiente"
  type        = string
  default     = ""
}

/*----------------Máquina Virtual-------------*/
variable "vm_name" {
  description = "Nome"
  type        = string
  default     = ""
}

variable "vm_size" {
  description = "Tamanho dos recursos"
  type        = string
  default     = ""

}

variable "vm_disk_size" {
  description = "Tamanho do disco"
  type        = string
  default     = ""

}

variable "vm_publisher" {
  description = "Publicador da imagem"
  type        = string
  default     = ""
}

variable "vm_offer" {
  description = "Tipo da imagem"
  type        = string
  default     = ""

}

variable "vm_sku" {
  description = "SKU da imagem"
  type        = string
  default     = ""

}

variable "vm_version" {
  description = "Versão a ser utilizada da imagem"
  type        = string
  default     = ""

}

variable "vm_admin_user" {
  description = "Usuário administrador"
  type        = string
  default     = ""
}

variable "vm_admin_password" {
  description = "Senha do usuário administrador"
  type        = string
  default     = ""
}

/*----------------Azure Data Factory-------------*/
variable "adf_name" {
  description = "Nome do recurso"
  type        = string
  default     = ""

}

variable "account_name" {
  description = "Nome da organização do Azure Devops"
  type        = string
  default     = ""

}

variable "branch_name" {
  description = "Nome da branch"
  type        = string
  default     = ""

}

variable "project_name" {
  description = "Nome do projeto"
  type        = string
  default     = ""

}

variable "repository_name" {
  description = "Nome do repositório"
  type        = string
  default     = ""

}

variable "root_folder" {
  description = "Caminho da pasta"
  type        = string
  default     = ""

}

variable "tenant_id" {
  description = "ID do Diretório Padrão (Entra ID)"
  type        = string
  default     = ""

}

/*----------------Blob Storage-------------*/
variable "sa_name" {
  description = "Nome da conta"
  type        = string
  default     = ""
}

variable "sc_name" {
  description = "Nome do container"
  type        = string
  default     = ""

}
