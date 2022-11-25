resource "aci_physical_domain" "BMaaS_Fabric" {
    name            =       "BMaaS_Fabric"
    relation_infra_rs_vlan_ns = aci_vlan_pool.vlan_pools["BMaaS_FABRIC"].id
}
