terraform {
  required_version = "= 1.2.3"

  required_providers {
    aws = {
      version = "= 4.24.0"
    }
    null = {
      version = "= 3.1.1"
    }
    # Simply for the sake of verification
    openstack = {
      source  = "terraform-provider-openstack/openstack"
      version = "= 1.42.0"
    }
  }
}
