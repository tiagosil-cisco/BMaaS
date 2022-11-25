resource "aci_application_epg" "epgs" {
  for_each = var.bridge_domains

  application_profile_dn  = aci_application_profile.BMaaS.id
  name                    = each.value.name
  relation_fv_rs_bd       = aci_bridge_domain.bridge_domains[each.value.name].id
  relation_fv_rs_cons     = [aci_contract.Project01.id]
  relation_fv_rs_prov     = [aci_contract.Project01.id]
}