locals {
  templates_deploy = false
  ddi_space        = "DOVETAIL"
  infra_name       = "BMaaS"
  onprem_block     = "10.10.0.0/16"
}

variable "aci_vlan_pools" {
  type = map(any)
  default = {
    BMaaS_L3OUT_CORE = {
      name       = "BMaaS_L3OUT_CORE"
      alloc_mode = "static"
    }
    BMaaS_FABRIC = {
      name       = "BMaaS_FABRIC"
      alloc_mode = "static"
    }
  }
}
variable "aci_vlan_pool_ranges" {
  type = map(any)
  default = {
    range1 = {
      from        = "vlan-1021"
      to          = "vlan-1030"
      description = "Pool to CORE for L3Outs"
      alloc_mode  = "inherit"
      role        = "external"
      pool        = "BMaaS_L3OUT_CORE"
    }
    range2 = {
      from        = "vlan-1011"
      to          = "vlan-1020"
      description = "Pool to Fabric for L2Dom"
      alloc_mode  = "inherit"
      role        = "external"
      pool        = "BMaaS_FABRIC"
    }
  }
}

variable "tenants" {
  type = map(any)
  default = {
    BMaaS = {
      name = "BMaaS"
    }

  }
}


variable "vrfs" {
  type = map(any)
  default = {
    BMaaS = {
      name   = "BMaaS"
      tenant = "BMaaS"
    }
  }
}

variable "bridge_domains" {
  type = map(any)
  default = {
    BMaaS_PROD01 = {
      name                = "BMaaS_PROD01"
      template            = "MAIN"
      tenant              = "BMaaS"
      application_profile = "BMaaS"
      vrf                 = "BMaaS"
      arp_flood           = "no"
      ip_learning         = "yes"
      unicast_route       = "yes"
      subnet_scope        = ["public", "shared"]
      prefered            = "yes"
      vmm_domain          = "DOVETAIL_VMM"
    },
    BMaaS_CIMC01 = {
      name                = "BMaaS_CIMC01"
      template            = "MAIN"
      tenant              = "BMaaS"
      application_profile = "BMaaS"
      vrf                 = "BMaaS"
      arp_flood           = "no"
      ip_learning         = "yes"
      unicast_route       = "yes"
      subnet_scope        = ["public"]
      prefered            = "yes"
      vmm_domain          = "DOVETAIL_VMM"
    },


  }
}

