
resource "aci_dhcp_relay_policy" "DHCP_RELAY" {

  tenant_dn  = aci_tenant.tenants["BMaaS"].id
  name       = "DHCP_RELAY"
  mode       = "visible"
  name_alias = "alias_example"
  owner      = "tenant"
  relation_dhcp_rs_prov {
    addr = "10.0.10.22"
    tdn  = aci_external_network_instance_profile.BMaaS-external_network_instance_profile.id
  }

}

resource "aci_bd_dhcp_label" "BMaaS_bd_dhcp_label" {
  for_each         = var.bridge_domains
  bridge_domain_dn = aci_bridge_domain.bridge_domains[each.value.name].id
  name             = "DHCP_RELAY"
  owner            = "tenant"

}
