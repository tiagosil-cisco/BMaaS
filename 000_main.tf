terraform {
  cloud {
    hostname     = "terraform.mgmt.dovetail-lab.ca"
    organization = "DOVETAIL"


    workspaces {
      name = "BMaaS"
    }
  }
  required_providers {
    solidserver = {
      source = "EfficientIP-Labs/solidserver"
    }
    aci = {
      source = "ciscodevnet/aci"
    }

  }
}

provider "solidserver" {
  username  = var.eip_username
  password  = var.eip_password
  host      = var.eip_url
  sslverify = "false"
}

provider "aci" {
  username = var.aci_username
  password = var.aci_password
  url      = var.aci_url
  insecure = true
}


