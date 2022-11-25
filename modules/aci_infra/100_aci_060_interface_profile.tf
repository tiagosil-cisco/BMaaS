resource "aci_leaf_interface_profile" "BMaaS_interface_profile" {
  description = local.description
  name        = "BMaaS_port_selector_VPCs"
}

resource "aci_access_port_selector" "BMaaS_port_selector_UCS-X-FI-A" {
  leaf_interface_profile_dn      = aci_leaf_interface_profile.BMaaS_interface_profile.id
  description                    = "BMaaS Demo"
  name                           = "BMaaS_port_selector_UCS-X-FI-A"
  access_port_selector_type      = "range"
  relation_infra_rs_acc_base_grp = aci_leaf_access_bundle_policy_group.BMaaS-Fabric_VPC-FI-A.id
}

resource "aci_access_port_selector" "BMaaS_port_selector_UCS-X-FI-B" {
  leaf_interface_profile_dn      = aci_leaf_interface_profile.BMaaS_interface_profile.id
  description                    = "BMaaS Demo"
  name                           = "BMaaS_port_selector_UCS-X-FI-B"
  access_port_selector_type      = "range"
  relation_infra_rs_acc_base_grp = aci_leaf_access_bundle_policy_group.BMaaS-Fabric_VPC-FI-B.id
}

resource "aci_access_port_block" "BMaaS_Fabric_FI-A" {
  access_port_selector_dn = aci_access_port_selector.BMaaS_port_selector_UCS-X-FI-A.id
  description             = "VPC to UCS-X FI-A"
  name                    = "BMaaS_Fabric_FI-A"
  from_card               = "1"
  from_port               = "11"
  to_card                 = "1"
  to_port                 = "11"
}

resource "aci_access_port_block" "BMaaS_Fabric_FI-B" {
  access_port_selector_dn = aci_access_port_selector.BMaaS_port_selector_UCS-X-FI-B.id
  description             = "VPC to UCS-X FI-B"
  name                    = "BMaaS_Fabric_FI-B"
  from_card               = "1"
  from_port               = "12"
  to_card                 = "1"
  to_port                 = "12"
}

