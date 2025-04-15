terraform {
  required_version = ">= 0.14.0"
  required_providers {
    openstack = {
      source  = "terraform-provider-openstack/openstack"
      version = "~> 1.53.0"
    }
  }
}

provider "openstack" {
  user_name   = "admin"
  tenant_name = "admin"
  password    = "0fDNqBcAY1NR8phFe60lrnbfgh0jyD7hu7HN1g3y"
  auth_url    = "http://192.168.1.254:5000/v3"
  region      = "RegionOne"
}