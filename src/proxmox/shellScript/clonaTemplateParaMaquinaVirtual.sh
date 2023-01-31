#!/bin/bash
CHAVE_PUBLICA=/root/.ssh/id_rsa.pub
ID_TEMPLATE=7000
ID_VIRTUALMACHINE=2000
IMAGEM=jammy-server-cloudimg-amd64.img
MEMORIA_RAM=2048
NOME_DO_TEMPLATE=Ubuntu22.04Server
NOME_VIRTUALMACHINE=AWX
TAMANHO_DISCO=+45G
URL=https://cloud-images.ubuntu.com/jammy/current/jammy-server-cloudimg-amd64.img
VCORE=2

qm clone $ID_TEMPLATE $ID_VIRTUALMACHINE --name $NOME_VIRTUALMACHINE --full
qm set $ID_VIRTUALMACHINE --ipconfig0 ip=dhcp
qm resize $ID_VIRTUALMACHINE scsi0 $TAMANHO_DISCO