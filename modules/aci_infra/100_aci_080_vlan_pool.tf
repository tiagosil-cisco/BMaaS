
data "aci_vlan_pool" "L3OUT_VLAN_Pool" {
  name       = "OTT-CORE-VPC3-VLANS"
  alloc_mode = "static"
}

resource "aci_ranges" "range_1" {
  vlan_pool_dn = data.aci_vlan_pool.L3OUT_VLAN_Pool.id
  description  = local.description
  from         = "vlan-${var.vlans_l3out.request_id}"
  to           = "vlan-${var.vlans_l3out.request_id}"
}
