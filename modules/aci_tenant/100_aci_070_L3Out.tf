

resource "aci_l3_outside" "BMaaS-L3OUT-BGP" {
  tenant_dn              = aci_tenant.tenants["BMaaS"].id
  name                   = "BMaaS-L3OUT-BGP"
  relation_l3ext_rs_ectx = aci_vrf.vrfs["BMaaS"].id
  relation_l3ext_rs_l3_dom_att = var.l3outs.id
}



resource "aci_external_network_instance_profile" "BMaaS-external_network_instance_profile" {
        l3_outside_dn  = aci_l3_outside.BMaaS-L3OUT-BGP.id
        name           = "ExtEPG"
        match_t        = "All"
        pref_gr_memb   = "exclude"
        relation_fv_rs_cons     = [aci_contract.L3OUT.id]
        relation_fv_rs_prov     = [aci_contract.L3OUT.id]

    }

resource "aci_l3_ext_subnet" "EXT_SUBNET_DEFAULT" {
  external_network_instance_profile_dn = aci_external_network_instance_profile.BMaaS-external_network_instance_profile.id
  ip                                   = "0.0.0.0/0"
}
resource "aci_logical_node_profile" "BMaaS_node_profile" {
        l3_outside_dn = aci_l3_outside.BMaaS-L3OUT-BGP.id
        name          = "BMaaS_node_profile"
  
}

resource "aci_l3out_bgp_protocol_profile" "BMaaS-bgp_protocol_profile" {
  logical_node_profile_dn  = aci_logical_node_profile.BMaaS_node_profile.id
}

resource "aci_l3out_bgp_external_policy" "BMaaS-bgp_ext_pol" {
  l3_outside_dn = aci_l3_outside.BMaaS-L3OUT-BGP.id
}

resource "aci_logical_node_to_fabric_node" "Leaf103" {
  logical_node_profile_dn  = aci_logical_node_profile.BMaaS_node_profile.id
  tdn               = "topology/pod-1/node-103"
  annotation        = "annotation"
  config_issues     = "none"
  rtr_id            = "10.255.255.254"
  rtr_id_loop_back  = "yes"
}

resource "aci_logical_node_to_fabric_node" "Leaf104" {
  logical_node_profile_dn  = aci_logical_node_profile.BMaaS_node_profile.id
  tdn               = "topology/pod-1/node-104"
  annotation        = "annotation"
  config_issues     = "none"
  rtr_id            = "10.255.255.253"
  rtr_id_loop_back  = "yes"
}

resource "aci_logical_interface_profile" "BMaaS-logical_interface_profile" {
        logical_node_profile_dn = aci_logical_node_profile.BMaaS_node_profile.id
        description             = "Sample logical interface profile"
        name                    = "L3OUT-to-CORE"
  }

resource "aci_l3out_path_attachment" "L3OUT_Path_Attachment" {
  logical_interface_profile_dn  = aci_logical_interface_profile.BMaaS-logical_interface_profile.id
  target_dn  = "topology/pod-1/protpaths-103-104/pathep-[OTT-CORE-VPC03]"
  if_inst_t = "ext-svi"
  description = "from terraform"
  encap  = "vlan-${var.vlans_l3out.request_id}"
  encap_scope = "local"
  mode = "regular"
  mtu = "inherit"

}

resource "aci_l3out_vpc_member" "L3OUT_SVI_A" {
  leaf_port_dn  = aci_l3out_path_attachment.L3OUT_Path_Attachment.id
  side  = "A"
  addr  = "10.0.0.1/16"
  annotation  = "example"
  ipv6_dad = "enabled"
  ll_addr  = "::"
  description = "from terraform"
  name_alias  = "example"
}

/*
resource "aci_l3out_floating_svi" "SVI_FLOATING_LEAF103" {
  logical_interface_profile_dn = aci_logical_interface_profile.COMPANY01-logical_interface_profile.id
  node_dn                      = "topology/pod-1/node-103"
  encap                        = "vlan-1400"
  addr                         = "10.10.3.252/24"
  autostate                    = "disabled"
  encap_scope                  = "local"
  if_inst_t                    = "ext-svi"
  mode                         = "regular"
  mtu                          = "1500"

  relation_l3ext_rs_dyn_path_att {
    tdn = data.aci_vmm_domain.aci_vmm_vds.id
    floating_address = "10.10.3.254/24"
    forged_transmit = "Enabled"
    mac_change = "Enabled"
    promiscuous_mode = "Enabled"
  }
}

resource "aci_l3out_floating_svi" "SVI_FLOATING_LEAF104" {
  logical_interface_profile_dn = aci_logical_interface_profile.COMPANY01-logical_interface_profile.id
  node_dn                      = "topology/pod-1/node-104"
  encap                        = "vlan-1400"
  addr                         = "10.10.3.253/24"
  autostate                    = "disabled"
  encap_scope                  = "local"
  if_inst_t                    = "ext-svi"
  mode                         = "regular"
  mtu                          = "1500"

  relation_l3ext_rs_dyn_path_att {
    tdn = data.aci_vmm_domain.aci_vmm_vds.id
    floating_address = "10.10.3.254/24"
    forged_transmit = "Enabled"
    mac_change = "Enabled"
    promiscuous_mode = "Enabled"
  }
}


resource "aci_bgp_peer_connectivity_profile" "BGP-PEER-Leaf103" {
  parent_dn           = aci_l3out_floating_svi.SVI_FLOATING_LEAF103.id
  addr                = "10.10.3.1"
  addr_t_ctrl         = ["af-ucast"]
  as_number           = "65002"
  local_asn           = "65003"
  admin_state         = "enabled"
}

resource "aci_bgp_peer_connectivity_profile" "BGP-PEER-Leaf104" {
  parent_dn           = aci_l3out_floating_svi.SVI_FLOATING_LEAF104.id
  addr                = "10.10.3.1"
  addr_t_ctrl         = ["af-ucast"]
  as_number           = "65002"
  local_asn           = "65003"
  admin_state         = "enabled"
}
*/