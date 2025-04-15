variable "image_id" {
  description = "ID da imagem Ubuntu 24.04 Server (UbuntuServer24.04)"
  type        = string
  default     = "ff2b754a-8fec-4e1a-8861-5ac77f4ee73e"
}

variable "external_network_id" {
  description = "ID da rede externa"
  type        = string
  default     = "8728e30b-aef5-43e8-b04d-26c8d07914e9"
}

variable "external_network_name" {
  description = "Nome da rede externa"
  type        = string
  default     = "public1"
}

variable "internal_network_cidr" {
  description = "CIDR da rede interna"
  type        = string
  default     = "10.0.0.0/24"
}

variable "dns_nameservers" {
  description = "Lista de servidores DNS"
  type        = list(string)
  default     = ["8.8.8.8", "8.8.4.4"]
}

variable "lan_cidr" {
  description = "CIDR da rede local para regras de segurança"
  type        = string
  default     = "192.168.1.0/24"
}

variable "ssh_allowed_cidr" {
  description = "CIDR permitido para acesso SSH"
  type        = string
  default     = "0.0.0.0/0"
}

variable "ssh_public_key_path" {
  description = "Caminho para a chave pública SSH"
  type        = string
  default     = "~/.ssh/id_rsa.pub"
}

variable "k3s_master_name" {
  description = "Nome da VM do master K3s"
  type        = string
  default     = "k3s-master"
}

variable "project_name" {
  description = "Nome do projeto para identificação única dos recursos"
  type        = string
  default     = "k3s-cluster" # Nome default baseado no propósito do projeto
}