resource "aci_physical_domain" "BMaaS_Fabric" {
  name                      = "BMaaS_Fabric"
  relation_infra_rs_vlan_ns = aci_vlan_pool.vlan_pools["BMaaS_FABRIC"].id
}


resource "aci_l3_domain_profile" "BMaaS_L3OUT_CORE" {
  name  = "BMaaS_L3OUT_CORE"
  relation_infra_rs_vlan_ns = aci_vlan_pool.vlan_pools["BMaaS_L3OUT_CORE"].id
}