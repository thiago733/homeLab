provider "proxmox" {
  pm_api_url          = "https://proxmox:8006/api2/json"
  pm_api_token_id     = "root@pam!terraform"
  pm_api_token_secret = "c86cab78-3bf1-46d1-8bb5-9ecb7e659447"
  pm_tls_insecure     = true
}
resource "proxmox_vm_qemu" "ubuntuserver" {
  name            = "ubuntuserver"
  target_node     = var.proxmox_host
  clone           = "Ubuntu22.04Server"
  os_type         = "cloud-init"
  count           = 1
  memory          = 4096
  cores           = 2
  scsihw          = "virtio-scsi-pci"
  bootdisk        = "scsi0"
  agent           = 1
  ssh_user        = "root"
  ssh_private_key = var.privatekey
  disk {
    slot    = 0
    size    = "32G"
    type    = "scsi"
    storage = "local-zfs"
  }
  network {
    model  = "virtio"
    bridge = "vmbr0"
  }
}