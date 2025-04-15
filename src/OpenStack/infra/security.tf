# SSH Keypairs
resource "openstack_compute_keypair_v2" "k3s_keypair" {
  name       = "${var.k3s_master_name}-keypair"
  public_key = file(var.ssh_public_key_path)
}

# Security Groups
resource "openstack_networking_secgroup_v2" "secgroup" {
  name        = "${var.project_name}-allow-access"
  description = "Allow inbound traffic from LAN for ${var.project_name}"
}

resource "openstack_networking_secgroup_rule_v2" "secgroup_rule_lan" {
  direction         = "ingress"
  ethertype         = "IPv4"
  protocol          = "tcp"
  remote_ip_prefix  = var.lan_cidr
  security_group_id = openstack_networking_secgroup_v2.secgroup.id
}

resource "openstack_networking_secgroup_rule_v2" "secgroup_rule_ssh" {
  direction         = "ingress"
  ethertype         = "IPv4"
  protocol          = "tcp"
  port_range_min    = 22
  port_range_max    = 22
  remote_ip_prefix  = var.ssh_allowed_cidr
  security_group_id = openstack_networking_secgroup_v2.secgroup.id
}