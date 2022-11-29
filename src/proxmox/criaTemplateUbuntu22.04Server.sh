#!/bin/bash
CHAVE_PUBLICA=/root/.ssh/id_rsa.pub
ID_VIRTUALMACHINE=7000
IMAGEM=jammy-server-cloudimg-amd64.img
MEMORIA_RAM=2048
NOME_DO_TEMPLATE=Ubuntu22.04Server
URL=https://cloud-images.ubuntu.com/jammy/current/jammy-server-cloudimg-amd64.img
VCORE=2

rm -rf $IMAGEM*
wget $IMAGEM $URL
qm create $ID_VIRTUALMACHINE --cores $VCORE --memory $MEMORIA_RAM --name $NOME_DO_TEMPLATE --net0 virtio,bridge=vmbr0
qm importdisk $ID_VIRTUALMACHINE $IMAGEM local-btrfs
qm set $ID_VIRTUALMACHINE --scsihw virtio-scsi-pci --scsi0 local-btrfs:$ID_VIRTUALMACHINE/vm-$ID_VIRTUALMACHINE-disk-0.raw
qm set $ID_VIRTUALMACHINE --ide2 local-btrfs:cloudinit
qm set $ID_VIRTUALMACHINE --boot c --bootdisk scsi0
qm set $ID_VIRTUALMACHINE --serial0 socket --vga serial0
qm set $ID_VIRTUALMACHINE --agent 1
qm set $ID_VIRTUALMACHINE --ciuser ansible --cipassword ansible
qm set $ID_VIRTUALMACHINE --machine q35
qm set $ID_VIRTUALMACHINE --sshkey $CHAVE_PUBLICA
qm template $ID_VIRTUALMACHINE
rm -rf $IMAGEM*