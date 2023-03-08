provider "proxmox" {
  pm_api_url          = "https://proxmox:8006/api2/json"
  pm_api_token_id     = var.pm_api_token_id
  pm_api_token_secret = var.pm_api_token_secret
  pm_tls_insecure     = true
}

resource "proxmox_vm_qemu" "opnSense" {
  clone       = "UbuntuServer2204"
  os_type     = "cloud-init"
  name        = "opnSense"
  target_node = var.proxmox_host
  memory      = 4096
  cores       = 4
  scsihw      = "virtio-scsi-pci"
  bootdisk    = "scsi0"
  agent       = 1
  disk {
    slot    = 0
    size    = "32G"
    type    = "scsi"
    storage = "local-btrfs"
  }
  network {
    model  = "virtio"
    bridge = "vmbr0"
    bridge = "vmbr1"
    macaddr = "92:54:08:65:ea:1a"
  }
}