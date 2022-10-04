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
  ssh_private_key = 
EOF
  os_type         = "cloud-init"
  sshkeys         = <<EOF
ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCamAxaNF+eNxWT2sx5uknmM93FfyOU7YaKNUmfmZrrUicL0ZzylPR1bRssab70RN/Oys2nMJX+LF5OWlikwP05gFCVWz83CP8qsFkNvMnA8z+QIo+rivemdzmvyasOkHPUKFXgoyL1Yi2uIojHvBBdTB6zSdNjx0X+fEZJuf0akMYTXMsqSA9flqJVShG64WXJuqp1FzUN3ekD8VyaK1FhD2N6LcgCsITeW59JUbPUIOmCi5wRtC5quxd/f7/IVxE26suEhrvck/ahKgXr6Z/qy7rJoDfMK2k7dYR2/S7KJgOnjtaV9ipnwwGrJz8WsrOFQXxTZpQ79sLoXrfC9fnD azuread\thiagofortes@DIGIX087
EOF
}