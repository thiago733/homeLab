provider "proxmox" {
  pm_api_url          = "https://proxmox:8006/api2/json"
  pm_api_token_id     = "root@pam!terraform"
  pm_api_token_secret = "c86cab78-3bf1-46d1-8bb5-9ecb7e659447"
  pm_tls_insecure     = true
}
resource "proxmox_vm_qemu" "ubuntuserver" {
  name        = "ubuntuserver"
  desc        = "Servidor com Ubuntu"
  target_node = var.proxmox_host
  clone       = "Ubuntu22.04Server"
  disk {
    type    = "virtio"
    storage = "local-zfs"
    size    = "32G"
  }
  network {
    model = "virtio"
  }
  cores           = 2
  sockets         = 1
  memory          = 4096
  agent           = 1
  ssh_user        = "root"
  ssh_private_key = var.privatekey
  os_type         = "cloud-init"
}