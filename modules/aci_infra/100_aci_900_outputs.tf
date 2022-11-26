output "l3outs" {
  value = aci_l3_domain_profile.BMaaS_L3OUT_CORE
}

output "physical_domain" {
  value = aci_physical_domain.BMaaS_Fabric
}

output "vpc_to_fi_a" {
  value = aci_leaf_access_bundle_policy_group.BMaaS-Fabric_VPC-FI-A

}

output "vpc_to_fi_b" {
  value = aci_leaf_access_bundle_policy_group.BMaaS-Fabric_VPC-FI-B

}