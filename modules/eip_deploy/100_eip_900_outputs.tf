output "subnets" {
  value = solidserver_ip_subnet.subnets
}

output "vlans_l3out" {
  value = solidserver_vlan.BMaaS_L3OUT
}

output "vlans_bridge_domains" {
  value = solidserver_vlan.BMaaS_Bridge_Domains
}

output "l3out_subnet" {
  value = solidserver_ip_subnet.BMaaS_L3OUT
}