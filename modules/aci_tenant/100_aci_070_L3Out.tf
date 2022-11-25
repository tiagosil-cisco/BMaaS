
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
  addr  = join("/",[cidrhost(var.l3out_subnet.prefix,1),var.l3out_subnet.prefix_size])
}
resource "aci_l3out_vpc_member" "L3OUT_SVI_B" {
  leaf_port_dn  = aci_l3out_path_attachment.L3OUT_Path_Attachment.id
  side  = "B"
  addr  = join("/",[cidrhost(var.l3out_subnet.prefix,2),var.l3out_subnet.prefix_size])
}

resource "aci_bgp_peer_connectivity_profile" "BGP-PEER-CORE01" {
  parent_dn           = aci_l3out_path_attachment.L3OUT_Path_Attachment.id
  addr                = cidrhost(var.l3out_subnet.prefix,5)
  addr_t_ctrl         = ["af-ucast"]
  as_number           = "65001"
  local_asn           = "65020"
  admin_state         = "enabled"
}

resource "aci_bgp_peer_connectivity_profile" "BGP-PEER-CORE02" {
  parent_dn           = aci_l3out_path_attachment.L3OUT_Path_Attachment.id
  addr                = cidrhost(var.l3out_subnet.prefix,6)
  addr_t_ctrl         = ["af-ucast"]
  as_number           = "65001"
  local_asn           = "65020"
  admin_state         = "enabled"
}