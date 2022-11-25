resource "aci_tenant" "tenants" {
  for_each = var.tenants
  name     = each.value.name
}