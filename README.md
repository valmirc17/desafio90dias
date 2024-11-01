# ☁️Implementação de Azure Data Factory em Ambiente Privado

## 📄Descrição

Este projeto utiliza Terraform para automatizar o provisionamento de recursos na Microsoft Azure em um ambiente privado. O projeto cria e configura uma Virtual Machine (VM) Windows, um Azure Data Factory (ADF) em rede privada, Blob Storage, e o Integration Runtime (IR) na VM. O ADF é sincronizado com um repositório privado no Azure DevOps e pipelines são automaticamente implantadas para integração com o Blob Storage.

💻 **Recursos provisionados**

* Azure Data Factory (ADF)
  * Provisionado em uma rede privada.
  * Sincronizado com um repositório Git privado no Azure DevOps.
  * Configurado para realizar automação de pipelines utilizando o Blob Storage.
  
* Virtual Machine (VM)
  * VM Windows provisionada em uma Virtual Network (VNet) privada.
  * Utilizada para a instalação do Integration Runtime (IR) e conexão com o ADF.
  
* Blob Storage
  * Criação e configuração de uma conta de armazenamento do tipo Blob para interação com o ADF.
  
* Integration Runtime (IR)
  * Instalado e configurado na VM para conectar-se ao ADF e suportar a movimentação de dados em rede privada.
  
* Azure DevOps Pipeline
  * Sincronização automática do ADF com o repositório Git privado no Azure DevOps.
  * Deploy automatizado de pipelines ADF para processar dados do Blob Storage.

✔️ **Pré-requisitos**
 * Conta Azure com permissões para criar recursos.
 * Repositório Git privado no Azure DevOps configurado.
 * Máquina com Terraform instalado.
 * Azure CLI configurado e autenticado.

📂 **Estrutura do projeto**
- **adf/**
  - `adf.tf`: Configuração do Azure Data Factory
  - `outputs.tf`: Outputs específicos do ADF
  - `private_endpoints.tf`: Configuração dos endpoints privados do ADF
  - `variables.tf`: Variáveis do módulo ADF
- **blob-storage/**
  - `blob.tf`: Configuração do Blob Storage
  - `outputs.tf`: Outputs específicos do Blob Storage
  - `variables.tf`: Variáveis do módulo Blob Storage
- **network/**
  - `network.tf`: Configuração da rede (VNet e Subnet)
  - `outputs.tf`: Outputs específicos da rede
  - `variables.tf`: Variáveis do módulo de rede
- **vm/**
  - `variables.tf`: Variáveis da VM
  - `vm.tf`: Configuração da Virtual Machine e Integration Runtime
- `main.tf`: Código principal que conecta todos os módulos
- `variables.tf`: Variáveis globais do projeto
- `README.md`: Documentação do projeto



<span>&#9881;</span> **Como executar o projeto**
1. **Clone o Repositório:** Clone este repositório GitHub para sua máquina local.
2. **Configure as Variáveis:** Edite o arquivo `terraform.tfvars` no diretório raiz do projeto e defina as variáveis de acordo com seu ambiente:
   Obs.: Há um arquivo `terraform.tfvars` compactado para que possa ser utilizado em ambiente de desenvolvimento.
4. **Inicialize o Terraform:** Abra um terminal no diretório raiz do projeto e execute os seguintes comandos:
    * `terraform init`: Inicializa o Terraform e baixa os provedores necessários
    * `terraform plan`: Gera um plano de execução que mostra as alterações que serão feitas
    * `terraform apply --auto-approve`: Aplica as alterações, aprova automaticamente e provisiona os recursos na Azure
5. **Configuração do Azure DevOps**
   Certifique-se de que o repositório Git privado no Azure DevOps esteja corretamente configurado e sincronizado com o ADF.


