resource "aci_vlan_pool" "vlan_pools" {
  description = local.description
  for_each   = var.aci_vlan_pools
  name       = each.value.name
  alloc_mode = each.value.alloc_mode

}


resource "aci_ranges" "ranges" {
  for_each     = var.aci_vlan_pool_ranges
  vlan_pool_dn = aci_vlan_pool.vlan_pools[each.value.pool].id
  description  = each.value.description
  from         = each.value.from
  to           = each.value.to
  alloc_mode   = each.value.alloc_mode
}