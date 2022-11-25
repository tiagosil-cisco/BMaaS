resource "solidserver_vlan_domain" "BMaaS" {
  name   = var.infra_name
}



resource "solidserver_vlan" "BMaaS_L3OUT" {
  vlan_domain      = solidserver_vlan_domain.BMaaS.name
  name             = "BMaaS_L3OUT"
}

