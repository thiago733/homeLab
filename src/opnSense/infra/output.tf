output "proxmox_ip_address_manager" {
  description = "Current IP Manager"
  value       = proxmox_vm_qemu.opnSense.*.default_ipv4_address
}