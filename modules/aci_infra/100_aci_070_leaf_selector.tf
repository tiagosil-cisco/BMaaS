resource "aci_leaf_profile" "BMaaS_leaf_profile" {
  name        = "BMaaS_leaf_profile"
  description = local.description
  leaf_selector {
    name                    = "BMaaS_103_104"
    switch_association_type = "range"
    node_block {
      name  = "blk1"
      from_ = "103"
      to_   = "104"
    }
  }
  relation_infra_rs_acc_port_p = [aci_leaf_interface_profile.BMaaS_interface_profile.id]
}