resource "aci_bridge_domain" "bridge_domains" {
  for_each           = var.bridge_domains
  tenant_dn          = aci_tenant.tenants[each.value.tenant].id
  relation_fv_rs_ctx = aci_vrf.vrfs[each.value.vrf].id
  name               = each.value.name
  arp_flood          = each.value.arp_flood
  ip_learning        = each.value.ip_learning
  unicast_route      = each.value.unicast_route
}


resource "aci_subnet" "subnets" {
  for_each  = var.bridge_domains
  parent_dn = aci_bridge_domain.bridge_domains[each.value.name].id
  ip        = "${var.subnets[each.value.name].gateway}/${var.subnets[each.value.name].prefix_size}"
  scope     = each.value.subnet_scope
}

