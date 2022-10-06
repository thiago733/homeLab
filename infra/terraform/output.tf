output "proxmox_ip_address_ubuntuServer" {
  description = "Current IP UbuntuServer"
  value       = proxmox_vm_qemu.ubuntuserver.*.default_ipv4_address
}