provider "proxmox" {
  pm_api_url          = "https://proxmox:8006/api2/json"
  pm_api_token_id     = "terraform-prov@pve!terraform-token"
  pm_api_token_secret = "4443f2d5-2f37-4509-8a17-19d8e91c7199"
  pm_tls_insecure     = true
}

resource "proxmox_vm_qemu" "piHole" {
  clone       = "UbuntuServer2204"
  os_type     = "cloud-init"
  name        = "piHole"
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
  }
}