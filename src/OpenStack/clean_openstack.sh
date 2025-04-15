#!/bin/bash

# Script para limpar todo o ambiente OpenStack
# Autor: GitHub Copilot
# Data: 15/04/2025

# Configuração de segurança do script
set -e  # Para o script se algum comando falhar
set -u  # Trata variáveis não definidas como erro

# Função para exibir mensagens com timestamp
log() {
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] $1"
}

# Função para confirmar ação
confirm() {
    read -p "⚠️  $1 (y/n) " -n 1 -r
    echo
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        log "❌ Operação cancelada pelo usuário"
        exit 1
    fi
}

# Verificar se as variáveis de ambiente do OpenStack estão configuradas
if [ -z "${OS_CLOUD:-}" ] && [ -z "${OS_AUTH_URL:-}" ]; then
    if [ -f "./clouds.yaml" ]; then
        export OS_CLOUD="kolla-admin"
        log "✅ Usando configuração do clouds.yaml com OS_CLOUD=kolla-admin"
    elif [ -f "./openrc.sh" ]; then
        source ./openrc.sh
        log "✅ Usando configuração do openrc.sh"
    else
        log "❌ Erro: Credenciais do OpenStack não encontradas"
        exit 1
    fi
fi

# Confirmação de segurança
confirm "Este script irá DELETAR TODOS os recursos do seu ambiente OpenStack. Deseja continuar?"

# Início da limpeza
log "🚀 Iniciando limpeza do ambiente OpenStack..."

# Removendo instâncias
log "📝 Removendo instâncias..."
for server in $(openstack server list -f value | awk '{print $1}'); do
    log "Deletando servidor: $server"
    openstack server delete $server
done

# Removendo IPs flutuantes
log "📝 Removendo IPs flutuantes..."
openstack floating ip list -f value | awk '{print $1}' | xargs -r openstack floating ip delete

# Removendo portas
log "📝 Removendo portas de rede..."
openstack port list -f value | awk '{print $1}' | xargs -r openstack port delete

# Removendo roteadores
log "📝 Removendo roteadores..."
for router in $(openstack router list -f value | awk '{print $1}'); do
    log "Processando roteador: $router"
    # Removendo interfaces do roteador
    for subnet in $(openstack router show $router -f json | jq -r '.interfaces_info[].subnet_id'); do
        log "Removendo subnet $subnet do roteador $router"
        openstack router remove subnet $router $subnet
    done
    # Removendo gateway externo
    openstack router unset --external-gateway $router
    # Deletando o roteador
    openstack router delete $router
done

# Removendo redes e subnets
log "📝 Removendo redes internas..."
openstack network list --internal -f value | awk '{print $1}' | xargs -r openstack network delete

# Removendo grupos de segurança (exceto o default)
log "📝 Removendo grupos de segurança..."
openstack security group list -f value | grep -v default | awk '{print $1}' | xargs -r openstack security group delete

# Removendo keypairs
log "📝 Removendo keypairs..."
openstack keypair list -f value | awk '{print $1}' | xargs -r openstack keypair delete

# Fim do script
log "✅ Ambiente OpenStack limpo com sucesso!"
log "⚠️  Nota: A rede externa 'public1' e o grupo de segurança 'default' foram mantidos por serem recursos essenciais do sistema."