/*
resource "solidserver_ip_pool" "IP_Pools" {
 for_each = var.bridge_domains
  space            = data.solidserver_ip_space.space.name
  subnet           = solidserver_ip_subnet.subnets[each.value.name].name
  name             = "${solidserver_ip_subnet.subnets[each.value.name].name}_Pool"
  start            = cidrhost(solidserver_ip_subnet.subnets[each.value.name].prefix, 30)
  size             = 200
  dhcp_range = true
}

*/