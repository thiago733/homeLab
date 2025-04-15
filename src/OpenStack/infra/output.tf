output "instance_ip" {
  value       = openstack_compute_instance_v2.k3s-master.access_ip_v4
  description = "O endereço IP da instância"
}

output "ssh_private_key" {
  value       = openstack_compute_keypair_v2.k3s_keypair.private_key
  sensitive   = true
  description = "A chave privada SSH para acesso à instância"
}

output "ssh_connection_string" {
  value       = "ssh -i ~/.ssh/id_rsa ubuntu@${openstack_compute_instance_v2.k3s-master.access_ip_v4}"
  description = "Comando para conectar via SSH na instância"
}

output "kubernetes_master_floating_ip" {
  value       = openstack_networking_floatingip_v2.k3s_ip.address
  description = "IP público do nó master do Kubernetes"
}

output "ssh_connection_command" {
  value       = "ssh ubuntu@${openstack_networking_floatingip_v2.k3s_ip.address}"
  description = "Comando para conectar via SSH no nó master"
}