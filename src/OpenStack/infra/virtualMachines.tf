# K3s Master Node
resource "openstack_compute_instance_v2" "k3s-master" {
  name            = var.k3s_master_name
  image_id        = var.image_id
  flavor_name     = "m1.small" # Using a smaller flavor initially
  key_pair        = openstack_compute_keypair_v2.k3s_keypair.name
  security_groups = [openstack_networking_secgroup_v2.secgroup.name]

  network {
    name = "internal_network" # Using internal network first
  }
}

# IP Flutuante para acesso externo
resource "openstack_networking_floatingip_v2" "k3s_ip" {
  pool = var.external_network_name
}

# Associação do IP Flutuante à VM
resource "openstack_compute_floatingip_associate_v2" "k3s_ip" {
  floating_ip = openstack_networking_floatingip_v2.k3s_ip.address
  instance_id = openstack_compute_instance_v2.k3s-master.id
}