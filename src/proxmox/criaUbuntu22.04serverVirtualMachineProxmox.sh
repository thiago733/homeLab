#!/bin/bash
URL=https://cloud-images.ubuntu.com/jammy/current/jammy-server-cloudimg-amd64.img
ID_VIRTUALMACHINE=7000
VCORE=2
MEMORIA_RAM=2048
IMAGEM=jammy-server-cloudimg-amd64.img
NOME_DO_TEMPLATE=Ubuntu22.04Server
wget -qSO $IMAGEM $URL
qm create $ID_VIRTUALMACHINE --cores $VCORE --memory $MEMORIA_RAM --name $NOME_DO_TEMPLATE --net0 virtio,bridge=vmbr0
qm importdisk $ID_VIRTUALMACHINE $IMAGEM local-zfs
qm set $ID_VIRTUALMACHINE --scsihw virtio-scsi-pci --scsi0 local-zfs:vm-$ID_VIRTUALMACHINE-disk-0
qm set $ID_VIRTUALMACHINE --ide2 local-zfs:cloudinit
qm set $ID_VIRTUALMACHINE --boot c --bootdisk scsi0
qm set $ID_VIRTUALMACHINE --serial0 socket --vga serial0
qm set $ID_VIRTUALMACHINE --agent 1