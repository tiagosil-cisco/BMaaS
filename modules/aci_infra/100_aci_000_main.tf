terraform {
  required_providers {
    aci = {
      source = "ciscodevnet/aci"
    }

  }
}




locals {
  description = "BMaaS Demo"
}
variable "aci_username" {
  description = "EIP Username"
}

variable "aci_password" {
  description = "EIP Password"
}

variable "aci_url" {
  description = "EIP URL"
}

variable "aci_vlan_pools" {
  description = "aci_vlan_pools"
}

variable "aci_vlan_pool_ranges" {
  description = "aci_vlan_pool_ranges"
}

variable "vlans_l3out" {
  description = "vlans_l3out"
}