
resource "aci_leaf_access_bundle_policy_group" "BMaaS-Fabric_VPC-FI-A" {
    name                            = "BMaaS-Fabric_VPC-FI-A"
    lag_t                           = "node"
    relation_infra_rs_cdp_if_pol    = aci_cdp_interface_policy.BMaaS_CDP_Enabled.id
    relation_infra_rs_lldp_if_pol   = aci_lldp_interface_policy.BMaaS_LLDP_Enabled.id
    relation_infra_rs_att_ent_p     = aci_attachable_access_entity_profile.BMaaS_Fabric_AAEP.id
    relation_infra_rs_lacp_pol      = aci_lacp_policy.BMaaS_LACP_Enabled.id
}

resource "aci_leaf_access_bundle_policy_group" "BMaaS-Fabric_VPC-FI-B" {
    name                            = "BMaaS-Fabric_VPC-FI-B"
    lag_t                           = "node"
    relation_infra_rs_cdp_if_pol    = aci_cdp_interface_policy.BMaaS_CDP_Enabled.id
    relation_infra_rs_lldp_if_pol   = aci_lldp_interface_policy.BMaaS_LLDP_Enabled.id
    relation_infra_rs_att_ent_p     = aci_attachable_access_entity_profile.BMaaS_Fabric_AAEP.id
    relation_infra_rs_lacp_pol      = aci_lacp_policy.BMaaS_LACP_Enabled.id
}