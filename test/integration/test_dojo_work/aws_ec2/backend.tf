terraform {
  required_version = "= 1.14.1"

  required_providers {
    aws = {
      version = "= 6.25.0"
    }
    null = {
      version = "= 3.2.4"
    }
    # Simply for the sake of verification
    openstack = {
      source  = "terraform-provider-openstack/openstack"
      version = "= 3.4.0"
    }
  }
}
