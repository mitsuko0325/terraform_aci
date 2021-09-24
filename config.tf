
resource "aci_tenant" "tenant" {
  name = var.tenant_name 
  description = "sarimits"
}

resource "aci_tenant" "terraform_import_test" {
  name = "terraform_import_test"
  description = "updated by terraform"
}

resource "aci_vrf" "vrf" {
  tenant_dn = aci_tenant.tenant.id
  name = "test_vrf"
}

resource "aci_vrf" "vrf_add_test" {
  tenant_dn = aci_tenant.tenant.id
  name = "vrf_add_test"
}

resource "aci_bridge_domain" "bd" {
   tenant_dn   = aci_tenant.tenant.id
   name        = "test_bd"
   relation_fv_rs_ctx = aci_vrf.vrf.id
}

resource "aci_subnet" "subnet" {
  parent_dn = aci_bridge_domain.bd.id
  ip = "192.168.1.254/24"  
}

resource "aci_application_profile" "ap" {
  tenant_dn = aci_tenant.tenant.id
  name = "test_ap"
}

resource "aci_application_epg" "epg" {
  application_profile_dn = aci_application_profile.ap.id
  relation_fv_rs_bd = aci_bridge_domain.bd.id
  name = "test_epg"
}



# resource "aci_application_profile" "myWebsite" {
#   tenant_dn = "${aci_tenant.conmurph_intro_to_terraform.id}"
#   name       = "my_website"
# }

# resource "aci_application_epg" "web" {
#     application_profile_dn  = "${aci_application_profile.myWebsite.id}"
#     name                            = "web"
#     description                   = "this is the web epg created by terraform"
#     flood_on_encap            = "disabled"
#     fwd_ctrl                    = "none"
#     has_mcast_source            = "no"
#     match_t                         = "AtleastOne"
#     name_alias                  = "web"
#     pc_enf_pref                 = "unenforced"
#     pref_gr_memb                = "exclude"
#     prio                            = "unspecified"
#     shutdown                    = "no"
#   }


# resource "aci_application_epg" "db" {
#     application_profile_dn  = "${aci_application_profile.myWebsite.id}"
#     name                            = "db-epg"
#     description                   = "this is the database epg created by terraform"
#     flood_on_encap            = "disabled"
#     fwd_ctrl                    = "none"
#     has_mcast_source            = "no"
#     match_t                         = "AtleastOne"
#     name_alias                  = "db"
#     pc_enf_pref                 = "unenforced"
#     pref_gr_memb                = "exclude"
#     prio                            = "unspecified"
#     shutdown                    = "no"
#   }
