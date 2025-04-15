# Internal network configuration
resource "openstack_networking_network_v2" "internal_network" {
  name           = "internal_network"
  admin_state_up = "true"
}

resource "openstack_networking_subnet_v2" "internal_subnet" {
  name            = "internal_subnet"
  network_id      = openstack_networking_network_v2.internal_network.id
  cidr            = var.internal_network_cidr
  ip_version      = 4
  dns_nameservers = var.dns_nameservers
}

# Router configuration
resource "openstack_networking_router_v2" "router" {
  name                = "main_router"
  admin_state_up      = true
  external_network_id = var.external_network_id
}

resource "openstack_networking_router_interface_v2" "router_interface" {
  router_id = openstack_networking_router_v2.router.id
  subnet_id = openstack_networking_subnet_v2.internal_subnet.id
}