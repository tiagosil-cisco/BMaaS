module "eip_deploy" {
  source = "./modules/eip_deploy"

  eip_password   = var.eip_password
  eip_url        = var.eip_url
  eip_username   = var.eip_username
  bridge_domains = var.bridge_domains
  ddi_space      = local.ddi_space
  onprem_block   = local.onprem_block
  infra_name     = local.infra_name

}

module "aci_infra" {
  depends_on = [
    module.eip_deploy
  ]
  source               = "./modules/aci_infra"
  aci_password         = var.aci_password
  aci_url              = var.aci_url
  aci_username         = var.aci_username
  aci_vlan_pools       = var.aci_vlan_pools
  aci_vlan_pool_ranges = var.aci_vlan_pool_ranges


}

module "aci_tenant" {
  depends_on = [
    module.aci_infra
  ]

  source = "./modules/aci_tenant"

  aci_password   = var.aci_password
  aci_url        = var.aci_url
  aci_username   = var.aci_username
  bridge_domains = var.bridge_domains
  tenants        = var.tenants
  vrfs           = var.vrfs
  subnets = module.eip_deploy.subnets
  l3outs = module.aci_infra.l3outs
  vlans_l3out = module.eip_deploy.vlans_l3out
  vlans_bridge_domains = module.eip_deploy.vlans_bridge_domains
  l3out_subnet = module.eip_deploy.l3out_subnet
}