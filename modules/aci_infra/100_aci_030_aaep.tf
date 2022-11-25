resource "aci_attachable_access_entity_profile" "BMaaS_Fabric_AAEP" {
  description             = local.description
  name                    = "BMaaS_Fabric_AAEP"
  relation_infra_rs_dom_p = [aci_physical_domain.BMaaS_Fabric.id]
}