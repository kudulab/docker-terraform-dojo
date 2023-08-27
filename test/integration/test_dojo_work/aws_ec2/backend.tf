terraform {
  required_version = "= 1.5.6"

  required_providers {
    aws = {
      version = "= 5.14.0"
    }
    null = {
      version = "= 3.2.1"
    }
    # Simply for the sake of verification
    openstack = {
      source  = "terraform-provider-openstack/openstack"
      version = "= 1.52.1"
    }
  }
}
