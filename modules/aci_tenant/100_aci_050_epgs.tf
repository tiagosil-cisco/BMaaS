resource "aci_application_epg" "epgs" {
  for_each = var.bridge_domains

  application_profile_dn = aci_application_profile.BMaaS.id
  name                   = each.value.name
  relation_fv_rs_bd      = aci_bridge_domain.bridge_domains[each.value.name].id
}

resource "aci_epg_to_contract" "PROD_TO_L3OUT_prov" {
  application_epg_dn = aci_application_epg.epgs[local.epg_cimc].id
  contract_dn        = aci_contract.CIMC_TO_L3OUT.id
  contract_type      = "provider"
}
resource "aci_epg_to_contract" "PROD_TO_L3OUT_cons" {
  application_epg_dn = aci_application_epg.epgs[local.epg_cimc].id
  contract_dn        = aci_contract.CIMC_TO_L3OUT.id
  contract_type      = "consumer"
}

resource "aci_epg_to_contract" "CIMC_TO_L3OUT_prov" {
  application_epg_dn = aci_application_epg.epgs[local.epg_prod].id
  contract_dn        = aci_contract.PROD_TO_L3OUT.id
  contract_type      = "provider"
}
resource "aci_epg_to_contract" "CIMC_TO_L3OUT_cons" {
  application_epg_dn = aci_application_epg.epgs[local.epg_prod].id
  contract_dn        = aci_contract.PROD_TO_L3OUT.id
  contract_type      = "consumer"
}

resource "aci_epg_to_domain" "EPG_to_Pyisical_domain" {
  for_each           = var.bridge_domains
  application_epg_dn = aci_application_epg.epgs[each.value.name].id
  tdn                = var.physical_domain.id

}

resource "aci_epg_to_static_path" "EPG_PROD_VLAN_FI-A-tag" {
  application_epg_dn = aci_application_epg.epgs["${local.epg_prod}"].id
  tdn                = "topology/pod-1/protpaths-103-104/pathep-[${var.vpc_to_fi_a.name}]"
  encap              = "vlan-${var.vlans_bridge_domains["${local.epg_prod}"].vlan_id}"
  mode               = "regular"

}

resource "aci_epg_to_static_path" "EPG_PROD_VLAN_FI-B-tag" {
  application_epg_dn = aci_application_epg.epgs["${local.epg_prod}"].id
  tdn                = "topology/pod-1/protpaths-103-104/pathep-[${var.vpc_to_fi_b.name}]"
  encap              = "vlan-${var.vlans_bridge_domains["${local.epg_prod}"].vlan_id}"
  mode               = "regular"

}

resource "aci_epg_to_static_path" "EPG_CIMC_VLAN_FI-A-tag" {
  application_epg_dn = aci_application_epg.epgs["${local.epg_cimc}"].id
  tdn                = "topology/pod-1/protpaths-103-104/pathep-[${var.vpc_to_fi_a.name}]"
  encap              = "vlan-${var.vlans_bridge_domains["${local.epg_cimc}"].vlan_id}"
  mode               = "regular"

}

resource "aci_epg_to_static_path" "EPG_CIMC_VLAN_FI-B-tag" {
  application_epg_dn = aci_application_epg.epgs["${local.epg_cimc}"].id
  tdn                = "topology/pod-1/protpaths-103-104/pathep-[${var.vpc_to_fi_b.name}]"
  encap              = "vlan-${var.vlans_bridge_domains["${local.epg_cimc}"].vlan_id}"
  mode               = "regular"

}