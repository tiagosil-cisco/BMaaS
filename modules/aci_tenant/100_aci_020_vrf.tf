resource "aci_vrf" "vrfs" {
  for_each  = var.vrfs
  tenant_dn = aci_tenant.tenants[each.value.tenant].id
  name      = each.value.name
}