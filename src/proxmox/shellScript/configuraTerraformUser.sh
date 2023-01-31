#!/bin/bash
LOGIN=terraform-prov@pve
ROLE=TerraformProv
SENHA=123456
TOKEN=terraform-token

pveum role add TerraformProv -privs "VM.Allocate VM.Clone VM.Config.CDROM VM.Config.CPU VM.Config.Cloudinit VM.Config.Disk VM.Config.HWType VM.Config.Memory VM.Config.Network VM.Config.Options VM.Monitor VM.Audit VM.PowerMgmt Datastore.AllocateSpace Datastore.Audit"
pveum user add $LOGIN --password $SENHA
pveum aclmod / -user $LOGIN -role $ROLE
pveum user token add $LOGIN $TOKEN --privsep=0