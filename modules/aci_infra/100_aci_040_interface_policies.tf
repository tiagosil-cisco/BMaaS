resource "aci_lldp_interface_policy" "BMaaS_LLDP_Enabled" {
  description = local.description
  name        = "BMaaS_LLDP_Enabled"
  admin_rx_st = "enabled"
  admin_tx_st = "enabled"
}

resource "aci_lacp_policy" "BMaaS_LACP_Enabled" {
  name        = "BMaaS_LACP_Enabled"
  description = local.description
  ctrl        = ["susp-individual", "fast-sel-hot-stdby", "graceful-conv"]
  max_links   = "16"
  min_links   = "1"
  mode        = "active"
}

resource "aci_cdp_interface_policy" "BMaaS_CDP_Enabled" {
  name     = "BMaaS_CDP_Enabled"
  admin_st = "enabled"

}