terraform {
  cloud {
    hostname     = "terraform.mgmt.dovetail-lab.ca"
    organization = "DOVETAIL"


    workspaces {
      name = "BMaaS"
    }
  }
  required_providers {


  }
}




