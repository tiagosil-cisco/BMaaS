resource "aci_attachable_access_entity_profile" "BMaaS_Fabric_AAEP" {
  description             = local.description
  name                    = "BMaaS_Fabric_AAEP"
  relation_infra_rs_dom_p = [aci_physical_domain.BMaaS_Fabric.id]
}

data "aci_attachable_access_entity_profile" "BMaaS_L3Out_AAEP" {
  name  = "OTT-CORE-AAEP"
}

resource "aci_aaep_to_domain" "L3Out_aaep_to_domain" {
  attachable_access_entity_profile_dn = data.aci_attachable_access_entity_profile.BMaaS_L3Out_AAEP.id
  domain_dn                           = aci_l3_domain_profile.BMaaS_L3OUT_CORE.id
}