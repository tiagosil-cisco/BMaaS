resource "solidserver_vlan_domain" "BMaaS" {
  name = var.infra_name
}



resource "solidserver_vlan" "BMaaS_L3OUT" {
  vlan_domain = solidserver_vlan_domain.BMaaS.name
  name        = "BMaaS_L3OUT"
    request_id = "1021"
}

resource "solidserver_vlan" "BMaaS_Bridge_Domains" {
  for_each = var.bridge_domains
  vlan_domain = solidserver_vlan_domain.BMaaS.name
  name        = each.value.name
    request_id = each.value.vlan_id
}

