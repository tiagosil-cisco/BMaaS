
data "solidserver_ip_space" "space" {
  name = var.ddi_space
}

resource "solidserver_ip_subnet" "ip_block" {
  space       = data.solidserver_ip_space.space.name
  request_ip  = split("/", var.onprem_block)[0]
  prefix_size = split("/", var.onprem_block)[1]
  name        = var.infra_name
  terminal    = false
}

resource "solidserver_ip_subnet" "BMaaS_L3OUT" {
  space       = data.solidserver_ip_space.space.name
  block       = solidserver_ip_subnet.ip_block.name
  terminal    = true
  name        = "BMaaS_L3OUT"
  request_ip = "10.10.21.0"
  prefix_size = 29
}



resource "solidserver_ip_subnet" "subnets" {
  for_each       = var.bridge_domains
  space          = data.solidserver_ip_space.space.name
  block          = solidserver_ip_subnet.ip_block.name
  terminal        = true
  name           = each.value.name
  gateway_offset = -1
  prefix_size    = 24
}

