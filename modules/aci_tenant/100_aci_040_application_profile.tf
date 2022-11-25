resource "aci_application_profile" "BMaaS" {
  tenant_dn         = aci_tenant.tenants["BMaaS"].id
  name              = "Projects"
}