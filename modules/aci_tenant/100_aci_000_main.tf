
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

variable "tenants" {
  description = "ACI tenants"
}

variable "vrfs" {
  description = "ACI VRFs"
}

variable "bridge_domains" {
  description = "ACI BDs"
}

variable "subnets" {
  description = "subnets"
}

variable "l3outs" {
  description = "l3outs"
}


variable "vlans_l3out" {
  description = "vlans_l3out"
}

variable "vlans_bridge_domains" {
  description = "vlans_bridge_domains"
}

variable "l3out_subnet" {
  description = "l3out_subnet"  
}
